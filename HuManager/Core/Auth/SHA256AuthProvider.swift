import Foundation
import os

final class SHA256AuthProvider: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "SHA256Auth")

    func login(
        client: HuaweiAPIClient,
        username: String,
        password: String,
        token: String,
        passwordType: String = "4"
    ) async throws {
        // Step 1: password_hash = base64(hex(SHA256(password)))
        let passwordHash = CryptoHelpers.sha256Base64Hex(password)

        // Step 2: login_value = base64(hex(SHA256(username + password_hash + token)))
        let combined = username + passwordHash + token
        let loginValue = CryptoHelpers.sha256Base64Hex(combined)

        logger.debug("Preparing SHA256 login: user=\(username), passwordType=\(passwordType)")

        // Step 3: Build XML body
        let body = XMLRequestBuilder.buildOrdered(elements: [
            ("Username", username),
            ("Password", loginValue),
            ("password_type", passwordType)
        ])

        // Step 4: POST to /api/user/login
        let (data, response) = try await client.postForLogin(
            Endpoints.login,
            body: body,
            token: token
        )

        // Step 5: Parse response
        let parsed = try XMLResponseParser.parseResponse(data: data)
        logger.info("SHA256 login successful")

        await client.session.setLoggedIn(true)
    }
}
