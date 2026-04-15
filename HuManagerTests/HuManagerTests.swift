import XCTest
@testable import HuManager

final class HuManagerTests: XCTestCase {

    func testXMLResponseParserSimple() throws {
        let xml = "<response><DeviceName>E5885</DeviceName><Imei>123456789</Imei></response>"
        let data = xml.data(using: .utf8)!
        let result = try XMLResponseParser.parseResponse(data: data)

        XCTAssertEqual(result["DeviceName"] as? String, "E5885")
        XCTAssertEqual(result["Imei"] as? String, "123456789")
    }

    func testXMLResponseParserError() {
        let xml = "<error><code>125003</code><message></message></error>"
        let data = xml.data(using: .utf8)!

        XCTAssertThrowsError(try XMLResponseParser.parseResponse(data: data)) { error in
            if case HuaweiAPIError.sessionExpired = error {
                // Expected
            } else {
                XCTFail("Expected sessionExpired, got \(error)")
            }
        }
    }

    func testXMLRequestBuilder() {
        let xml = XMLRequestBuilder.build(elements: ["Username": "admin", "Password": "test"])
        XCTAssertTrue(xml.hasPrefix("<?xml version=\"1.0\""))
        XCTAssertTrue(xml.contains("<Username>admin</Username>"))
        XCTAssertTrue(xml.contains("<Password>test</Password>"))
        XCTAssertTrue(xml.hasSuffix("</request>"))
    }

    func testCryptoSHA256Hex() {
        let result = CryptoHelpers.sha256Hex("test")
        XCTAssertEqual(result, "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08")
    }

    func testCryptoXOR() {
        let a = Data([0xFF, 0x00, 0xAA])
        let b = Data([0x0F, 0xF0, 0x55])
        let result = CryptoHelpers.xorBytes(a, b)
        XCTAssertEqual(result, Data([0xF0, 0xF0, 0xFF]))
    }

    func testDataHexConversion() {
        let data = Data([0xDE, 0xAD, 0xBE, 0xEF])
        XCTAssertEqual(data.hexString, "deadbeef")

        let roundTrip = Data(hexString: "deadbeef")
        XCTAssertEqual(roundTrip, data)
    }

    func testXMLEscaping() {
        let xml = XMLRequestBuilder.build(elements: ["Content": "Hello <world> & \"friends\""])
        XCTAssertTrue(xml.contains("Hello &lt;world&gt; &amp; &quot;friends&quot;"))
    }
}
