import Foundation

final class XMLResponseParser: NSObject, XMLParserDelegate, @unchecked Sendable {

    private var result: [String: Any] = [:]
    private var elementStack: [(name: String, children: [String: Any])] = []
    private var currentText = ""
    private var parseError: Error?

    func parse(data: Data) throws -> [String: Any] {
        result = [:]
        elementStack = []
        currentText = ""
        parseError = nil

        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()

        if parseError != nil {
            throw HuaweiAPIError.xmlParsingFailed(raw: String(data: data, encoding: .utf8) ?? "binary")
        }
        if let parserError = parser.parserError {
            throw HuaweiAPIError.xmlParsingFailed(raw: parserError.localizedDescription)
        }

        return result
    }

    // MARK: - XMLParserDelegate

    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?,
        attributes: [String: String]
    ) {
        currentText = ""
        elementStack.append((name: elementName, children: [:]))
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentText += string
    }

    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName: String?
    ) {
        guard let current = elementStack.popLast() else { return }

        let value: Any
        if current.children.isEmpty {
            let trimmed = currentText.trimmingCharacters(in: .whitespacesAndNewlines)
            value = trimmed
        } else {
            value = current.children
        }

        if elementStack.isEmpty {
            result[current.name] = value
        } else {
            let parentIndex = elementStack.count - 1
            if let existing = elementStack[parentIndex].children[elementName] {
                if var array = existing as? [Any] {
                    array.append(value)
                    elementStack[parentIndex].children[elementName] = array
                } else {
                    elementStack[parentIndex].children[elementName] = [existing, value]
                }
            } else {
                elementStack[parentIndex].children[elementName] = value
            }
        }

        currentText = ""
    }

    func parser(_ parser: XMLParser, parseErrorOccurred error: Error) {
        parseError = error
    }
}

// MARK: - Response Helpers

extension XMLResponseParser {

    static func parseResponse(data: Data) throws -> [String: Any] {
        let parser = XMLResponseParser()
        let parsed = try parser.parse(data: data)

        if let errorDict = parsed["error"] as? [String: Any] {
            let codeStr = errorDict["code"] as? String ?? "0"
            let code = Int(codeStr) ?? 0
            let message = errorDict["message"] as? String ?? ""

            if let knownCode = HuaweiErrorCode(rawValue: code) {
                if knownCode == .wrongSession || knownCode == .wrongSessionToken {
                    throw HuaweiAPIError.sessionExpired
                }
                throw HuaweiAPIError.apiError(code: knownCode, message: message)
            }
            throw HuaweiAPIError.unknownAPIError(code: code, message: message)
        }

        if let response = parsed["response"] as? [String: Any] {
            return response
        }

        if let response = parsed["response"] as? String, response == "OK" {
            return ["status": "OK"]
        }

        return parsed
    }
}
