import Foundation
import os

final class SHA256AuthProvider: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "SHA256Auth")

    func login(
        client: HuaweiAPIClient,
        username: String,
        password: String,
        token: String
    ) async throws {
        // Step 1: password_hash = base64(hex(SHA256(password)))
        let passwordHash = CryptoHelpers.sha256Base64Hex(password)

        // Step 2: login_value = base64(hex(SHA256(username + password_hash + token)))
        let combined = username + passwordHash + token
        let loginValue = CryptoHelpers.sha256Base64Hex(combined)

        logger.debug("SHA256 login hazırlanıyor: user=\(username)")

        // Step 3: Build XML body
        let body = XMLRequestBuilder.buildOrdered(elements: [
            ("Username", username),
            ("Password", loginValue),
            ("password_type", "4")
        ])

        // Step 4: POST to /api/user/login
        let (data, response) = try await client.postForLogin(
            Endpoints.login,
            body: body,
            token: token
        )

        // Step 5: Parse response
        let parsed = try XMLResponseParser.parseResponse(data: data)
        logger.info("SHA256 login başarılı")

        await client.session.setLoggedIn(true)
    }
}
