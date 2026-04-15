import Foundation

struct TrafficStatistics: Sendable {
    // Current session
    let currentDownload: UInt64
    let currentUpload: UInt64
    let currentConnectTime: Int
    let currentDownloadRate: UInt64
    let currentUploadRate: UInt64

    // Totals
    let totalDownload: UInt64
    let totalUpload: UInt64
    let totalConnectTime: Int

    init(from dict: [String: Any]) {
        currentDownload = UInt64(dict["CurrentDownload"] as? String ?? "0") ?? 0
        currentUpload = UInt64(dict["CurrentUpload"] as? String ?? "0") ?? 0
        currentConnectTime = Int(dict["CurrentConnectTime"] as? String ?? "0") ?? 0
        currentDownloadRate = UInt64(dict["CurrentDownloadRate"] as? String ?? "0") ?? 0
        currentUploadRate = UInt64(dict["CurrentUploadRate"] as? String ?? "0") ?? 0
        totalDownload = UInt64(dict["TotalDownload"] as? String ?? "0") ?? 0
        totalUpload = UInt64(dict["TotalUpload"] as? String ?? "0") ?? 0
        totalConnectTime = Int(dict["TotalConnectTime"] as? String ?? "0") ?? 0
    }
}

struct MonthStatistics: Sendable {
    let monthDownload: UInt64
    let monthUpload: UInt64
    let monthDuration: Int

    init(from dict: [String: Any]) {
        monthDownload = UInt64(dict["CurrentMonthDownload"] as? String ?? "0") ?? 0
        monthUpload = UInt64(dict["CurrentMonthUpload"] as? String ?? "0") ?? 0
        monthDuration = Int(dict["MonthDuration"] as? String ?? "0") ?? 0
    }
}
