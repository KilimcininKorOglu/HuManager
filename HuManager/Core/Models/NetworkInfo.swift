import Foundation

struct NetworkInfo: Sendable {
    let state: String
    let fullName: String
    let shortName: String
    let numeric: String
    let rat: String
    let roaming: Bool

    var networkTypeDisplay: String {
        switch rat {
        case "0": "2G (GSM)"
        case "2": "3G (WCDMA)"
        case "7": "4G (LTE)"
        case "11": "5G (NR)"
        // H153-381 firmware 4.0.0.5 reports 12 while registered on 5G SA.
        case "12": "5G (NR)"
        default: rat.isEmpty ? LocalizationManager.shared.t(L.general.unknown) : rat
        }
    }

    init(from dict: [String: Any]) {
        state = dict["State"] as? String ?? ""
        fullName = dict["FullName"] as? String ?? ""
        shortName = dict["ShortName"] as? String ?? ""
        numeric = dict["Numeric"] as? String ?? ""
        rat = dict["Rat"] as? String ?? ""
        roaming = (dict["Roaming"] as? String ?? "0") != "0"
    }
}
