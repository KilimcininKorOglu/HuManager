import Foundation

struct SMSMessage: Identifiable, Hashable, Sendable {
    let index: String
    let phone: String
    let content: String
    let date: String
    let smstat: String
    let smsType: Int
    let boxType: Int

    var id: String { index }

    var isRead: Bool { smstat != "0" }

    var parsedDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: date)
    }

    init(from dict: [String: Any]) {
        index = dict["Index"] as? String ?? ""
        phone = dict["Phone"] as? String ?? ""
        content = dict["Content"] as? String ?? ""
        date = dict["Date"] as? String ?? ""
        smstat = dict["Smstat"] as? String ?? "0"
        smsType = Int(dict["SmsType"] as? String ?? "0") ?? 0
        boxType = Int(dict["BoxType"] as? String ?? "1") ?? 1
    }
}

struct SMSCount: Sendable {
    let localInbox: Int
    let localOutbox: Int
    let localDraft: Int
    let localUnread: Int
    let simInbox: Int
    let simOutbox: Int
    let simDraft: Int
    let simUnread: Int
    let newMsg: Int

    var totalUnread: Int { localUnread + simUnread }

    init(from dict: [String: Any]) {
        localInbox = Int(dict["LocalInbox"] as? String ?? "0") ?? 0
        localOutbox = Int(dict["LocalOutbox"] as? String ?? "0") ?? 0
        localDraft = Int(dict["LocalDraft"] as? String ?? "0") ?? 0
        localUnread = Int(dict["LocalUnread"] as? String ?? "0") ?? 0
        simInbox = Int(dict["SimInbox"] as? String ?? "0") ?? 0
        simOutbox = Int(dict["SimOutbox"] as? String ?? "0") ?? 0
        simDraft = Int(dict["SimDraft"] as? String ?? "0") ?? 0
        simUnread = Int(dict["SimUnread"] as? String ?? "0") ?? 0
        newMsg = Int(dict["NewMsg"] as? String ?? "0") ?? 0
    }
}
