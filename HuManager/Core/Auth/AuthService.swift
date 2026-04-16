import Foundation
import os

final class AuthService: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "AuthService")
    private let versionDetector = WebUIVersionDetector()
    private let sha256Provider = SHA256AuthProvider()
    private let scramProvider = SCRAMAuthProvider()

    struct AuthResult: Sendable {
        let version: WebUIVersion
        let token: String
    }

    func login(
        client: HuaweiAPIClient,
        username: String,
        password: String
    ) async throws -> AuthResult {
        // Step 0: Reset any prior session state
        await client.session.reset()

        // Step 1: Initialize session — GET root to establish SessionID cookie
        logger.info("Starting session...")
        do {
            let _ = try await client.getRaw("/")
        } catch {
            logger.debug("Root GET error (may be expected): \(error.localizedDescription)")
        }

        // Step 2: Detect WebUI version and extract initial token
        logger.info("Detecting WebUI version...")
        let detection = try await versionDetector.detect(using: client)
        logger.info("WebUI v\(detection.version.rawValue) detected")

        // Step 3: Set initial token
        await client.session.setInitialToken(detection.token)

        // Step 4: Check login state and get password_type
        let passwordType = await getPasswordType(client: client)
        logger.debug("password_type: \(passwordType)")

        // Step 5: Dispatch to appropriate auth provider
        switch detection.version {
        case .v17, .v21:
            logger.info("Using SHA256 auth (v\(detection.version.rawValue))")
            try await sha256Provider.login(
                client: client,
                username: username,
                password: password,
                token: detection.token,
                passwordType: passwordType
            )

        case .v10:
            logger.info("Using SCRAM auth (v10)")
            // v10: re-fetch token right before login (as per Python reference)
            let freshToken = await refreshTokenForV10(client: client) ?? detection.token
            await client.session.setInitialToken(freshToken)
            try await scramProvider.login(
                client: client,
                username: username,
                password: password,
                token: freshToken
            )
        }

        // Step 6: Refresh session token after successful login
        await refreshSessionToken(client: client)

        return AuthResult(version: detection.version, token: detection.token)
    }

    func logout(client: HuaweiAPIClient) async throws {
        let body = XMLRequestBuilder.buildOrdered(elements: [
            ("Logout", "1")
        ])
        _ = try await client.post(Endpoints.logout, body: body)
        await client.session.reset()
        logger.info("Logged out")
    }

    // MARK: - Private Helpers

    private func getPasswordType(client: HuaweiAPIClient) async -> String {
        do {
            let response = try await client.get(Endpoints.stateLogin)
            return response["password_type"] as? String ?? "4"
        } catch {
            logger.debug("state-login failed, defaulting to password_type=4")
            return "4"
        }
    }

    private func refreshTokenForV10(client: HuaweiAPIClient) async -> String? {
        do {
            let response = try await client.get(Endpoints.webserverToken)
            if let fullToken = response["token"] as? String, !fullToken.isEmpty {
                let start = fullToken.index(fullToken.startIndex, offsetBy: max(0, fullToken.count - 32))
                return String(fullToken[start...])
            }
        } catch {
            logger.debug("v10 token refresh error: \(error.localizedDescription)")
        }
        return nil
    }

    private func refreshSessionToken(client: HuaweiAPIClient) async {
        do {
            let response = try await client.get(Endpoints.sesTokInfo)

            if let sessionId = response["SesInfo"] as? String {
                let cleanSession = sessionId.replacingOccurrences(of: "SessionID=", with: "")
                await client.session.updateSessionId(cleanSession)
            }

            if let token = response["TokInfo"] as? String {
                await client.session.setInitialToken(token)
            }

            logger.debug("Session token refreshed")
        } catch {
            logger.warning("SesTokInfo failed, continuing with current token")
        }
    }
}
