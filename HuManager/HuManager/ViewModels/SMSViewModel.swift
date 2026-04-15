import Foundation

@MainActor @Observable
final class SMSViewModel {
    var messages: [SMSMessage] = []
    var smsCount: SMSCount?
    var isLoading = false
    var selectedMessage: SMSMessage?
    var errorMessage: String?

    // Compose state
    var composePhone = ""
    var composeContent = ""
    var isSending = false
    var showCompose = false

    private let smsService = SMSService()
    private var currentPage = 1

    func loadInbox(client: HuaweiAPIClient) async {
        isLoading = true
        errorMessage = nil
        currentPage = 1

        do {
            async let msgs = smsService.getMessages(client: client, page: 1)
            async let count = smsService.getCount(client: client)

            messages = try await msgs
            smsCount = try await count
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func loadMore(client: HuaweiAPIClient) async {
        currentPage += 1
        do {
            let moreMessages = try await smsService.getMessages(client: client, page: currentPage)
            messages.append(contentsOf: moreMessages)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func sendSMS(client: HuaweiAPIClient) async {
        guard !composePhone.isEmpty, !composeContent.isEmpty else { return }
        isSending = true

        do {
            try await smsService.sendSMS(client: client, phone: composePhone, content: composeContent)
            composePhone = ""
            composeContent = ""
            showCompose = false
            await loadInbox(client: client)
        } catch {
            errorMessage = error.localizedDescription
        }

        isSending = false
    }

    func deleteSMS(client: HuaweiAPIClient, message: SMSMessage) async {
        do {
            try await smsService.deleteSMS(client: client, index: message.index)
            messages.removeAll { $0.id == message.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func markAsRead(client: HuaweiAPIClient, message: SMSMessage) async {
        do {
            try await smsService.markAsRead(client: client, index: message.index)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
