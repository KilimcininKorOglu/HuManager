import Foundation
import os

final class HuaweiAPIClient: Sendable {

    let baseURL: URL
    let session: SessionManager
    private let urlSession: URLSession
    private let logger = Logger(subsystem: "com.humanager", category: "APIClient")
    private let timeout: TimeInterval = 30

    init(host: String, scheme: String = "http") {
        self.baseURL = URL(string: "\(scheme)://\(host)")!
        self.session = SessionManager()

        let config = URLSessionConfiguration.ephemeral
        config.httpShouldSetCookies = false
        config.httpCookieAcceptPolicy = .never
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        self.urlSession = URLSession(configuration: config)
    }

    // MARK: - URL Helper

    private func makeURL(_ endpoint: String) -> URL {
        URL(string: baseURL.absoluteString + endpoint)!
    }

    // MARK: - GET

    func get(_ endpoint: String) async throws -> [String: Any] {
        let url = makeURL(endpoint)
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "GET"
        await applyCommonHeaders(&request)

        let (data, response) = try await performRequest(request)
        await processResponse(response)

        #if DEBUG
        let bodyPreview = String(data: data, encoding: .utf8)?.prefix(200) ?? "nil"
        print("[DEBUG GET] \(endpoint) → \(bodyPreview)")
        #endif

        return try XMLResponseParser.parseResponse(data: data)
    }

    func getRaw(_ endpoint: String) async throws -> (Data, HTTPURLResponse) {
        let url = makeURL(endpoint)
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "GET"
        await applyCommonHeaders(&request)

        let (data, response) = try await performRequest(request)
        await processResponse(response)

        return (data, response)
    }

    func getHTML(_ endpoint: String) async throws -> String {
        let url = makeURL(endpoint)
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "GET"
        await applyCommonHeaders(&request)

        let (data, response) = try await performRequest(request)
        await processResponse(response)

        guard let html = String(data: data, encoding: .utf8) else {
            throw HuaweiAPIError.xmlParsingFailed(raw: "UTF-8 conversion error")
        }
        return html
    }

    // MARK: - POST

    func post(_ endpoint: String, body: String) async throws -> [String: Any] {
        let url = makeURL(endpoint)
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "POST"
        await applyCommonHeaders(&request)
        await applyCSRFToken(&request)

        let cleanBody = body.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }.joined()
        request.httpBody = cleanBody.data(using: .utf8)
        request.setValue("application/xml", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await performRequest(request)
        await processResponse(response)

        #if DEBUG
        let bodyPreview = String(data: data, encoding: .utf8)?.prefix(200) ?? "nil"
        print("[DEBUG POST] \(endpoint) → \(bodyPreview)")
        #endif

        return try XMLResponseParser.parseResponse(data: data)
    }

    func postForLogin(_ endpoint: String, body: String, token: String? = nil, sendCookies: Bool = false) async throws -> (Data, HTTPURLResponse) {
        let url = makeURL(endpoint)
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = "POST"

        // Login requests: only send X-Requested-With and token, NOT cookies
        // (matches Python reference: cookies=None for v17/21 login)
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")

        if sendCookies {
            if let cookie = await session.buildCookieHeader() {
                request.setValue(cookie, forHTTPHeaderField: "Cookie")
            }
        }

        if let token {
            request.setValue(token, forHTTPHeaderField: "__RequestVerificationToken")
        } else {
            await applyCSRFToken(&request)
        }

        let cleanBody = body.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }.joined()
        request.httpBody = cleanBody.data(using: .utf8)
        request.setValue("application/xml", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await performRequest(request)
        await processResponse(response)

        #if DEBUG
        let bodyPreview = String(data: data, encoding: .utf8)?.prefix(300) ?? "nil"
        let cookieInfo = sendCookies ? "cookies=yes" : "cookies=no"
        print("[DEBUG POST-LOGIN] \(endpoint) [\(cookieInfo)] → \(bodyPreview)")
        #endif

        return (data, response)
    }

    // MARK: - Private

    private func applyCommonHeaders(_ request: inout URLRequest) async {
        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")

        if let cookie = await session.buildCookieHeader() {
            request.setValue(cookie, forHTTPHeaderField: "Cookie")
        }
    }

    private func applyCSRFToken(_ request: inout URLRequest) async {
        if let token = await session.currentToken {
            request.setValue(token, forHTTPHeaderField: "__RequestVerificationToken")
        }
    }

    private func performRequest(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await urlSession.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw HuaweiAPIError.connectionFailed(underlying: "No HTTP response received")
            }

            guard httpResponse.statusCode == 200 else {
                throw HuaweiAPIError.connectionFailed(
                    underlying: "HTTP \(httpResponse.statusCode)"
                )
            }

            return (data, httpResponse)
        } catch let error as HuaweiAPIError {
            throw error
        } catch let error as URLError where error.code == .timedOut {
            throw HuaweiAPIError.timeout
        } catch let error as URLError where error.code == .cannotConnectToHost {
            throw HuaweiAPIError.notConnected
        } catch {
            throw HuaweiAPIError.connectionFailed(underlying: error.localizedDescription)
        }
    }

    private func processResponse(_ response: HTTPURLResponse) async {
        await session.processResponseHeaders(response)
    }
}
