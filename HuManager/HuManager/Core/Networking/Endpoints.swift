import Foundation

enum Endpoints {
    // MARK: - Auth & Session
    static let stateLogin = "/api/user/state-login"
    static let login = "/api/user/login"
    static let challengeLogin = "/api/user/challenge_login"
    static let authenticationLogin = "/api/user/authentication_login"
    static let sesTokInfo = "/api/webserver/SesTokInfo"
    static let webserverToken = "/api/webserver/token"
    static let heartbeat = "/api/user/heartbeat"
    static let logout = "/api/user/logout"

    // MARK: - Device
    static let deviceInfo = "/api/device/information"
    static let basicInfo = "/api/device/basic_information"
    static let deviceSignal = "/api/device/signal"
    static let deviceControl = "/api/device/control"
    static let antennaType = "/api/device/antenna_type"

    // MARK: - Network
    static let netMode = "/api/net/net-mode"
    static let currentPLMN = "/api/net/current-plmn"

    // MARK: - SMS
    static let smsList = "/api/sms/sms-list"
    static let sendSMS = "/api/sms/send-sms"
    static let deleteSMS = "/api/sms/delete-sms"
    static let smsCount = "/api/sms/sms-count"
    static let setRead = "/api/sms/set-read"

    // MARK: - Monitoring
    static let monitoringStatus = "/api/monitoring/status"
    static let trafficStatistics = "/api/monitoring/traffic-statistics"
    static let monthStatistics = "/api/monitoring/month_statistics"
    static let clearTraffic = "/api/monitoring/clear-traffic"

    // MARK: - WiFi
    static let wifiSettings = "/api/wlan/multi-basic-settings"
    static let connectedDevices = "/api/wlan/host-list"
    static let macFilter = "/api/wlan/multi-macfilter-settings"
    static let wifiSwitch = "/api/wlan/status-switch-settings"

    // MARK: - Dialup
    static let connection = "/api/dialup/connection"
    static let mobileDataSwitch = "/api/dialup/mobile-dataswitch"

    // MARK: - HTML (token extraction)
    static let homeHTML = "/html/home.html"
}
