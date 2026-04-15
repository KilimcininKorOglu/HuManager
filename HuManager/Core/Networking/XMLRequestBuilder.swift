import Foundation

enum XMLRequestBuilder {

    static func build(elements: [String: String]) -> String {
        var xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request>"
        for (key, value) in elements {
            xml += "<\(key)>\(escapeXML(value))</\(key)>"
        }
        xml += "</request>"
        return xml
    }

    static func buildOrdered(elements: [(String, String)]) -> String {
        var xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request>"
        for (key, value) in elements {
            xml += "<\(key)>\(escapeXML(value))</\(key)>"
        }
        xml += "</request>"
        return xml
    }

    static func buildSMS(phones: [String], content: String, length: Int? = nil) -> String {
        var xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><request>"
        xml += "<Index>-1</Index>"
        xml += "<Phones>"
        for phone in phones {
            xml += "<Phone>\(escapeXML(phone))</Phone>"
        }
        xml += "</Phones>"
        xml += "<Sca/>"
        xml += "<Content>\(escapeXML(content))</Content>"
        xml += "<Length>\(length ?? content.count)</Length>"
        xml += "<Reserved>1</Reserved>"

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        xml += "<Date>\(formatter.string(from: Date()))</Date>"
        xml += "</request>"
        return xml
    }

    static func buildSMSList(page: Int = 1, count: Int = 20, boxType: Int = 1) -> String {
        return buildOrdered(elements: [
            ("PageIndex", "\(page)"),
            ("ReadCount", "\(count)"),
            ("BoxType", "\(boxType)"),
            ("SortType", "0"),
            ("Ascending", "0"),
            ("UnreadPreferred", "1")
        ])
    }

    private static func escapeXML(_ string: String) -> String {
        var escaped = string
        escaped = escaped.replacingOccurrences(of: "&", with: "&amp;")
        escaped = escaped.replacingOccurrences(of: "<", with: "&lt;")
        escaped = escaped.replacingOccurrences(of: ">", with: "&gt;")
        escaped = escaped.replacingOccurrences(of: "\"", with: "&quot;")
        escaped = escaped.replacingOccurrences(of: "'", with: "&apos;")
        return escaped
    }
}
