import Foundation

struct WiFiSettings: Sendable {
    let ssid: String
    let wifiEnable: Bool
    let channel: String
    let securityMode: String
    let wepKey: String
    let wpaKey: String
    let wifiMode: String
    let maxUsers: Int
    let band: String

    init(from dict: [String: Any]) {
        ssid = dict["WifiSsid"] as? String ?? dict["Ssid"] as? String ?? ""
        wifiEnable = (dict["WifiEnable"] as? String ?? "1") == "1"
        channel = dict["WifiChannel"] as? String ?? dict["Channel"] as? String ?? "0"
        securityMode = dict["WifiAuthmode"] as? String ?? dict["SecurityMode"] as? String ?? ""
        wepKey = dict["WifiWepKey1"] as? String ?? ""
        wpaKey = dict["WifiWpapsk"] as? String ?? dict["WpaPreSharedKey"] as? String ?? ""
        wifiMode = dict["WifiMode"] as? String ?? ""
        maxUsers = Int(dict["WifiMaxAssoc"] as? String ?? "0") ?? 0
        band = dict["WifiBand"] as? String ?? ""
    }
}

struct ConnectedDevice: Identifiable, Sendable {
    let macAddress: String
    let ipAddress: String
    let hostName: String
    let associatedTime: String

    var id: String { macAddress }

    init(from dict: [String: Any]) {
        macAddress = dict["MacAddress"] as? String ?? ""
        ipAddress = dict["IpAddress"] as? String ?? ""
        hostName = dict["HostName"] as? String ?? ""
        associatedTime = dict["AssociatedTime"] as? String ?? ""
    }
}
