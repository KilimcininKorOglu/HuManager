import Foundation
import os

final class SCRAMAuthProvider: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "SCRAMAuth")

    func login(
        client: HuaweiAPIClient,
        username: String,
        password: String,
        token: String
    ) async throws {
        // Step 1: Generate client nonce (64 hex chars)
        let clientNonce = CryptoHelpers.generateNonce(byteCount: 32)

        logger.debug("SCRAM challenge başlatılıyor: user=\(username)")

        // Step 2: Challenge request
        let challengeBody = XMLRequestBuilder.buildOrdered(elements: [
            ("username", username),
            ("firstnonce", clientNonce),
            ("mode", "1")
        ])

        let (challengeData, _) = try await client.postForLogin(
            Endpoints.challengeLogin,
            body: challengeBody,
            token: token
        )

        let challengeResponse = try XMLResponseParser.parseResponse(data: challengeData)

        guard let salt = challengeResponse["salt"] as? String,
              let serverNonce = challengeResponse["servernonce"] as? String,
              let iterationsStr = challengeResponse["iterations"] as? String,
              let iterations = Int(iterationsStr) else {
            throw HuaweiAPIError.authenticationFailed(
                reason: "SCRAM challenge yanıtı eksik: salt, servernonce veya iterations bulunamadı"
            )
        }

        logger.debug("SCRAM challenge alındı: iterations=\(iterations)")

        // Step 3: Derive authentication proof
        let clientProofHex = try computeClientProof(
            password: password,
            salt: salt,
            clientNonce: clientNonce,
            serverNonce: serverNonce,
            iterations: iterations
        )

        // Step 4: Authentication request
        let authBody = XMLRequestBuilder.buildOrdered(elements: [
            ("clientproof", clientProofHex),
            ("finalnonce", serverNonce)
        ])

        let (authData, _) = try await client.postForLogin(
            Endpoints.authenticationLogin,
            body: authBody,
            token: token
        )

        let _ = try XMLResponseParser.parseResponse(data: authData)
        logger.info("SCRAM login başarılı")

        await client.session.setLoggedIn(true)
    }

    // MARK: - SCRAM Proof Computation

    private func computeClientProof(
        password: String,
        salt: String,
        clientNonce: String,
        serverNonce: String,
        iterations: Int
    ) throws -> String {
        // salt is hex string, convert to bytes
        guard let saltData = Data(hexString: salt) else {
            throw HuaweiAPIError.authenticationFailed(reason: "Salt hex formatı geçersiz")
        }

        // msg = "clientNonce,serverNonce,serverNonce"
        let msg = "\(clientNonce),\(serverNonce),\(serverNonce)"

        // PBKDF2-HMAC-SHA256(password, salt, iterations)
        let saltedPassword = CryptoHelpers.pbkdf2SHA256(
            password: password,
            salt: saltData,
            iterations: iterations
        )

        // clientKey = HMAC-SHA256(saltedPassword, "Client Key")
        // NOTE: Python code uses HMAC(b'Client Key', msg=saltedPassword)
        // which means key="Client Key", message=saltedPassword
        let clientKey = CryptoHelpers.hmacSHA256(
            key: Data("Client Key".utf8),
            data: saltedPassword
        )

        // storedKey = SHA256(clientKey)
        let storedKeyData = CryptoHelpers.sha256Data(clientKey)

        // signature = HMAC-SHA256(storedKey, msg)
        // Python: HMAC(msg.encode(), msg=storedKey.digest())
        // key=msg, message=storedKey
        let signature = CryptoHelpers.hmacSHA256(
            key: Data(msg.utf8),
            data: storedKeyData
        )

        // clientProof = XOR(clientKey, signature)
        let clientProof = CryptoHelpers.xorBytes(clientKey, signature)

        return clientProof.hexString
    }
}
