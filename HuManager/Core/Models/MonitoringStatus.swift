import Foundation

struct MonitoringStatus: Sendable {
    let connectionStatus: Int
    let signalIcon: Int
    let signalStrength: Int
    let currentNetworkType: Int
    let currentServiceDomain: Int
    let wifiStatus: Bool
    let batteryStatus: String
    let batteryLevel: String
    let batteryPercent: String
    let simStatus: String
    let primaryDNS: String
    let secondaryDNS: String

    var isConnected: Bool {
        connectionStatus == 901
    }

    var networkTypeDisplay: String {
        switch currentNetworkType {
        case 0: "Bağlantı yok"
        case 1: "GSM"
        case 2: "GPRS"
        case 3: "EDGE"
        case 4: "WCDMA"
        case 5: "HSDPA"
        case 6: "HSUPA"
        case 7: "HSPA"
        case 8: "TD-SCDMA"
        case 9: "HSPA+"
        case 19: "LTE"
        case 41: "UMTS"
        case 44: "HSPA+"
        case 45: "HSPA+ DC"
        case 46: "LTE+"
        case 64: "LTE-A"
        case 65: "LTE-A Pro"
        case 101: "5G NSA"
        case 102: "5G SA"
        default: "Tür: \(currentNetworkType)"
        }
    }

    init(from dict: [String: Any]) {
        connectionStatus = Int(dict["ConnectionStatus"] as? String ?? "0") ?? 0
        signalIcon = Int(dict["SignalIcon"] as? String ?? "0") ?? 0
        signalStrength = Int(dict["SignalStrength"] as? String ?? "0") ?? 0
        currentNetworkType = Int(dict["CurrentNetworkType"] as? String ?? "0") ?? 0
        currentServiceDomain = Int(dict["CurrentServiceDomain"] as? String ?? "0") ?? 0
        wifiStatus = (dict["WifiStatus"] as? String ?? "0") != "0"
        batteryStatus = dict["BatteryStatus"] as? String ?? ""
        batteryLevel = dict["BatteryLevel"] as? String ?? ""
        batteryPercent = dict["BatteryPercent"] as? String ?? ""
        simStatus = dict["simlockStatus"] as? String ?? dict["SimStatus"] as? String ?? ""
        primaryDNS = dict["PrimaryDns"] as? String ?? ""
        secondaryDNS = dict["SecondaryDns"] as? String ?? ""
    }
}
