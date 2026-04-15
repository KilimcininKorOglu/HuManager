import Foundation

struct DeviceInfo: Sendable {
    let deviceName: String
    let serialNumber: String
    let imei: String
    let imsi: String
    let iccid: String
    let msisdn: String
    let hardwareVersion: String
    let softwareVersion: String
    let webUIVersion: String
    let macAddress: String
    let wanIPAddress: String
    let classify: String
    let supportMode: String
    let workMode: String

    init(from dict: [String: Any]) {
        deviceName = dict["DeviceName"] as? String ?? ""
        serialNumber = dict["SerialNumber"] as? String ?? ""
        imei = dict["Imei"] as? String ?? ""
        imsi = dict["Imsi"] as? String ?? ""
        iccid = dict["Iccid"] as? String ?? ""
        msisdn = dict["Msisdn"] as? String ?? ""
        hardwareVersion = dict["HardwareVersion"] as? String ?? ""
        softwareVersion = dict["SoftwareVersion"] as? String ?? ""
        webUIVersion = dict["WebUIVersion"] as? String ?? ""
        macAddress = dict["MacAddress1"] as? String ?? dict["MacAddress2"] as? String ?? ""
        wanIPAddress = dict["WanIPAddress"] as? String ?? ""
        classify = dict["Classify"] as? String ?? ""
        supportMode = dict["supportmode"] as? String ?? ""
        workMode = dict["workmode"] as? String ?? ""
    }
}
