import Foundation
import os

enum WebUIVersion: Int, Sendable {
    case v10 = 10
    case v17 = 17
    case v21 = 21
}

struct WebUIDetectionResult: Sendable {
    let version: WebUIVersion
    let token: String
}

final class WebUIVersionDetector: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "WebUIDetector")

    func detect(using client: HuaweiAPIClient) async throws -> WebUIDetectionResult {
        // Step 1: Try /api/webserver/token (WebUI v10/v21)
        if let result = try await detectViaTokenAPI(client: client) {
            return result
        }

        // Step 2: Fallback to /html/home.html (WebUI v17)
        if let result = try await detectViaHTML(client: client) {
            return result
        }

        throw HuaweiAPIError.authenticationFailed(reason: "WebUI versiyonu algılanamadı")
    }

    // MARK: - Token API (v10/v21)

    private func detectViaTokenAPI(client: HuaweiAPIClient) async throws -> WebUIDetectionResult? {
        do {
            let response = try await client.get(Endpoints.webserverToken)

            guard let fullToken = response["token"] as? String, !fullToken.isEmpty else {
                logger.info("Token API yanıt verdi ama token boş")
                return nil
            }

            // Extract last 32 characters
            let tokenLength = fullToken.count
            let startIndex = fullToken.index(fullToken.startIndex, offsetBy: max(0, tokenLength - 32))
            let token = String(fullToken[startIndex...])

            logger.info("Token API'den token alındı, v10 varsayılan")

            // Check if v21
            if let version = try await checkForV21(client: client) {
                return WebUIDetectionResult(version: version, token: token)
            }

            return WebUIDetectionResult(version: .v10, token: token)
        } catch {
            logger.info("Token API erişilemedi: \(error.localizedDescription)")
            return nil
        }
    }

    private func checkForV21(client: HuaweiAPIClient) async throws -> WebUIVersion? {
        do {
            let basicInfo = try await client.get(Endpoints.basicInfo)

            if let webUIVersion = basicInfo["WebUIVersion"] as? String,
               webUIVersion.contains("21.") {
                logger.info("WebUI v21 algılandı: \(webUIVersion)")
                return .v21
            }
        } catch {
            logger.debug("basic_information endpoint erişilemedi")
        }
        return nil
    }

    // MARK: - HTML Meta Tag (v17)

    private func detectViaHTML(client: HuaweiAPIClient) async throws -> WebUIDetectionResult? {
        do {
            let html = try await client.getHTML(Endpoints.homeHTML)

            guard let token = extractCSRFToken(from: html) else {
                logger.warning("HTML'de csrf_token bulunamadı")
                return nil
            }

            logger.info("HTML meta tag'den token alındı, v17")
            return WebUIDetectionResult(version: .v17, token: token)
        } catch {
            logger.info("HTML endpoint erişilemedi: \(error.localizedDescription)")
            return nil
        }
    }

    private func extractCSRFToken(from html: String) -> String? {
        // Pattern: <meta name="csrf_token" content="TOKEN_VALUE">
        // or: name="csrf_token" content="..."
        let patterns = [
            #"name\s*=\s*"csrf_token"\s+content\s*=\s*"([^"]+)""#,
            #"content\s*=\s*"([^"]+)"\s+name\s*=\s*"csrf_token""#
        ]

        for pattern in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
               let match = regex.firstMatch(in: html, range: NSRange(html.startIndex..., in: html)),
               let tokenRange = Range(match.range(at: 1), in: html) {
                return String(html[tokenRange])
            }
        }

        return nil
    }
}
