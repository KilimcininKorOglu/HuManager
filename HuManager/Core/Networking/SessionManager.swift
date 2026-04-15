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
        #if DEBUG
        let allHeaders = response.allHeaderFields
        print("[DEBUG HEADERS] URL: \(response.url?.path ?? "?") | Status: \(response.statusCode)")
        for (key, value) in allHeaders {
            let k = "\(key)"
            if k.lowercased().contains("cookie") || k.lowercased().contains("token") || k.lowercased().contains("session") {
                print("  \(k): \(value)")
            }
        }
        #endif

        // Token rotation from response headers
        if let tokenHeader = response.value(forHTTPHeaderField: "__RequestVerificationToken") {
            let parts = tokenHeader.split(separator: "#").map(String.init).filter { !$0.isEmpty }

            if parts.count > 1 {
                tokens = Array(parts.dropFirst(2))
            } else if parts.count == 1 {
                tokens.append(parts[0])
            }
            #if DEBUG
            print("[DEBUG] Token stack updated: \(tokens.count) tokens")
            #endif
        }

        // Extract SessionID using HTTPCookie parser (handles multiple Set-Cookie headers)
        let url = response.url ?? URL(string: "http://localhost")!
        let headerFields = response.allHeaderFields as? [String: String] ?? [:]
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)

        #if DEBUG
        if !cookies.isEmpty {
            print("[DEBUG] Cookies parsed: \(cookies.map { "\($0.name)=\($0.value.prefix(12))..." })")
        }
        #endif

        for cookie in cookies where cookie.name == "SessionID" {
            sessionId = cookie.value
            #if DEBUG
            print("[DEBUG] SessionID set: \(cookie.value.prefix(16))...")
            #endif
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
