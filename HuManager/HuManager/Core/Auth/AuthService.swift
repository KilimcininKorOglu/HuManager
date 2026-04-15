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
        // Step 1: Detect WebUI version and extract initial token
        logger.info("WebUI versiyonu algılanıyor...")
        let detection = try await versionDetector.detect(using: client)

        logger.info("WebUI v\(detection.version.rawValue) algılandı")

        // Step 2: Set initial token in session manager
        await client.session.setInitialToken(detection.token)

        // Step 3: Dispatch to appropriate auth provider
        switch detection.version {
        case .v17, .v21:
            logger.info("SHA256 auth kullanılıyor (v\(detection.version.rawValue))")
            try await sha256Provider.login(
                client: client,
                username: username,
                password: password,
                token: detection.token
            )

        case .v10:
            logger.info("SCRAM auth kullanılıyor (v10)")
            try await scramProvider.login(
                client: client,
                username: username,
                password: password,
                token: detection.token
            )
        }

        // Step 4: Refresh session token after login
        try await refreshSessionToken(client: client)

        return AuthResult(version: detection.version, token: detection.token)
    }

    func logout(client: HuaweiAPIClient) async throws {
        let body = XMLRequestBuilder.buildOrdered(elements: [
            ("Logout", "1")
        ])
        _ = try await client.post(Endpoints.logout, body: body)
        await client.session.reset()
        logger.info("Oturumdan çıkış yapıldı")
    }

    // MARK: - Session Token Refresh

    private func refreshSessionToken(client: HuaweiAPIClient) async throws {
        do {
            let response = try await client.get(Endpoints.sesTokInfo)

            if let sessionId = response["SesInfo"] as? String {
                let cleanSession = sessionId.replacingOccurrences(of: "SessionID=", with: "")
                await client.session.updateSessionId(cleanSession)
            }

            if let token = response["TokInfo"] as? String {
                await client.session.setInitialToken(token)
            }

            logger.debug("Session token yenilendi")
        } catch {
            logger.warning("SesTokInfo alınamadı, mevcut token ile devam ediliyor")
        }
    }
}
