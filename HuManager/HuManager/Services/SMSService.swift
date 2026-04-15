import Foundation
import os

final class SMSService: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "SMSService")

    func getCount(client: HuaweiAPIClient) async throws -> SMSCount {
        let response = try await client.get(Endpoints.smsCount)
        return SMSCount(from: response)
    }

    func getMessages(
        client: HuaweiAPIClient,
        page: Int = 1,
        count: Int = 20,
        boxType: Int = 1
    ) async throws -> [SMSMessage] {
        let body = XMLRequestBuilder.buildSMSList(page: page, count: count, boxType: boxType)
        let response = try await client.post(Endpoints.smsList, body: body)

        guard let messagesRaw = response["Messages"] as? [String: Any] else {
            return []
        }

        // Handle single message or array
        if let messageArray = messagesRaw["Message"] as? [[String: Any]] {
            return messageArray.map { SMSMessage(from: $0) }
        } else if let singleMessage = messagesRaw["Message"] as? [String: Any] {
            return [SMSMessage(from: singleMessage)]
        }

        return []
    }

    func sendSMS(client: HuaweiAPIClient, phone: String, content: String) async throws {
        let body = XMLRequestBuilder.buildSMS(phones: [phone], content: content)
        _ = try await client.post(Endpoints.sendSMS, body: body)
        logger.info("SMS gönderildi: \(phone)")
    }

    func deleteSMS(client: HuaweiAPIClient, index: String) async throws {
        let body = XMLRequestBuilder.buildOrdered(elements: [("Index", index)])
        _ = try await client.post(Endpoints.deleteSMS, body: body)
        logger.info("SMS silindi: index=\(index)")
    }

    func markAsRead(client: HuaweiAPIClient, index: String) async throws {
        let body = XMLRequestBuilder.buildOrdered(elements: [("Index", index)])
        _ = try await client.post(Endpoints.setRead, body: body)
    }
}
