import Foundation
import os

actor SessionManager {

    private let logger = Logger(subsystem: "com.humanager", category: "SessionManager")

    private(set) var sessionId: String?
    private var tokens: [String] = []
    private(set) var isLoggedIn = false

    var currentToken: String? {
        if tokens.isEmpty {
            logger.warning("Token yığını boş — yeniden giriş gerekli")
            return nil
        }
        return tokens.removeLast()
    }

    var peekToken: String? {
        tokens.last
    }

    var hasTokens: Bool {
        !tokens.isEmpty
    }

    // MARK: - Token Management

    func setInitialToken(_ token: String) {
        tokens = [token]
        logger.debug("İlk token ayarlandı")
    }

    func processResponseHeaders(_ response: HTTPURLResponse) {
        // Token rotation from response headers
        if let tokenHeader = response.value(forHTTPHeaderField: "__RequestVerificationToken") {
            let parts = tokenHeader.split(separator: "#").map(String.init).filter { !$0.isEmpty }

            if parts.count > 1 {
                tokens = Array(parts.dropFirst(2))
            } else if parts.count == 1 {
                tokens.append(parts[0])
            }
            logger.debug("Token güncellendi, yığın: \(self.tokens.count)")
        }

        // Extract SessionID using HTTPCookie parser (handles multiple Set-Cookie headers)
        let url = response.url ?? URL(string: "http://localhost")!
        let headerFields = response.allHeaderFields as? [String: String] ?? [:]
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)

        for cookie in cookies where cookie.name == "SessionID" {
            sessionId = cookie.value
            logger.debug("SessionID güncellendi: \(cookie.value.prefix(8))...")
            break
        }
    }

    func updateSessionId(_ id: String) {
        sessionId = id
    }

    func setLoggedIn(_ value: Bool) {
        isLoggedIn = value
    }

    func reset() {
        sessionId = nil
        tokens = []
        isLoggedIn = false
        logger.info("Oturum sıfırlandı")
    }

    // MARK: - Cookie Builder

    func buildCookieHeader() -> String? {
        guard let sessionId else { return nil }
        return "SessionID=\(sessionId)"
    }
}
