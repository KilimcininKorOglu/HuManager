import Foundation

// Type-safe localization keys — use with LocalizationManager.t()
// Usage: manager.t(L.general.connect)
enum L {
    enum general {
        static let appName = "general.appName"
        static let appSubtitle = "general.appSubtitle"
        static let connect = "general.connect"
        static let connecting = "general.connecting"
        static let disconnect = "general.disconnect"
        static let connected = "general.connected"
        static let disconnected = "general.disconnected"
        static let error = "general.error"
        static let unknownError = "general.unknownError"
        static let ok = "general.ok"
        static let cancel = "general.cancel"
        static let apply = "general.apply"
        static let send = "general.send"
        static let delete = "general.delete"
        static let refresh = "general.refresh"
        static let loading = "general.loading"
        static let noData = "general.noData"
        static let start = "general.start"
        static let stop = "general.stop"
        static let live = "general.live"
        static let yes = "general.yes"
        static let no = "general.no"
    }

    enum login {
        static let modemIP = "login.modemIP"
        static let username = "login.username"
        static let password = "login.password"
        static let rememberMe = "login.rememberMe"
    }

    enum sidebar {
        static let dashboard = "sidebar.dashboard"
        static let signal = "sidebar.signal"
        static let bands = "sidebar.bands"
        static let sms = "sidebar.sms"
        static let network = "sidebar.network"
        static let traffic = "sidebar.traffic"
        static let wifi = "sidebar.wifi"
        static let device = "sidebar.device"
    }

    enum dashboard {
        static let title = "dashboard.title"
        static let signalQuality = "dashboard.signalQuality"
        static let networkInfo = "dashboard.networkInfo"
        static let trafficTitle = "dashboard.traffic"
        static let deviceTitle = "dashboard.device"
        static let waitingSignal = "dashboard.waitingSignal"
        static let waitingNetwork = "dashboard.waitingNetwork"
        static let waitingTraffic = "dashboard.waitingTraffic"
        static let waitingDevice = "dashboard.waitingDevice"
    }

    enum signal {
        static let title = "signal.title"
        static let lteMetrics = "signal.lteMetrics"
        static let nrMetrics = "signal.nrMetrics"
        static let rsrpHistory = "signal.rsrpHistory"
        static let sinrHistory = "signal.sinrHistory"
        static let waitingSignal = "signal.waiting"
        static let clearHistory = "signal.clearHistory"
    }

    enum band {
        static let title = "band.title"
        static let activeBand = "band.activeBand"
        static let networkMode = "band.networkMode"
        static let lteBands = "band.lteBands"
        static let nrBands = "band.nrBands"
        static let selectAll = "band.selectAll"
        static let selectNone = "band.selectNone"
        static let resetAuto = "band.resetAuto"
    }

    enum sms {
        static let title = "sms.title"
        static let inbox = "sms.inbox"
        static let unread = "sms.unread"
        static let noMessages = "sms.noMessages"
        static let selectMessage = "sms.selectMessage"
        static let newSMS = "sms.newSMS"
        static let phoneNumber = "sms.phoneNumber"
        static let characters = "sms.characters"
    }

    enum traffic {
        static let title = "traffic.title"
        static let currentSession = "traffic.currentSession"
        static let total = "traffic.total"
        static let monthly = "traffic.monthly"
        static let download = "traffic.download"
        static let upload = "traffic.upload"
        static let dlSpeed = "traffic.dlSpeed"
        static let ulSpeed = "traffic.ulSpeed"
        static let duration = "traffic.duration"
        static let connectTime = "traffic.connectTime"
    }

    enum wifi {
        static let title = "wifi.title"
        static let settings = "wifi.settings"
        static let connectedDevices = "wifi.connectedDevices"
        static let noDevices = "wifi.noDevices"
        static let ssid = "wifi.ssid"
        static let status = "wifi.status"
        static let channel = "wifi.channel"
        static let security = "wifi.security"
        static let wifiPassword = "wifi.password"
        static let maxUsers = "wifi.maxUsers"
        static let automatic = "wifi.automatic"
        static let enabled = "wifi.enabled"
        static let disabled = "wifi.disabled"
        static let deviceName = "wifi.deviceName"
        static let ipAddress = "wifi.ipAddress"
        static let macAddress = "wifi.macAddress"
    }

    enum device {
        static let title = "device.title"
        static let deviceInfo = "device.info"
        static let software = "device.software"
        static let networkSection = "device.network"
        static let control = "device.control"
        static let reboot = "device.reboot"
        static let rebootConfirmTitle = "device.rebootConfirmTitle"
        static let rebootConfirmMessage = "device.rebootConfirmMessage"
        static let model = "device.model"
        static let serialNo = "device.serialNo"
        static let hardware = "device.hardware"
        static let firmwareLabel = "device.firmware"
    }

    enum status {
        static let connectionConnected = "status.connected"
        static let connectionDisconnected = "status.disconnected"
        static let roaming = "status.roaming"
        static let signalLabel = "status.signal"
        static let battery = "status.battery"
        static let connection = "status.connection"
        static let operatorLabel = "status.operator"
        static let networkType = "status.networkType"
        static let plmn = "status.plmn"
    }

    enum quality {
        static let excellent = "quality.excellent"
        static let good = "quality.good"
        static let fair = "quality.fair"
        static let poor = "quality.poor"
        static let noSignal = "quality.noSignal"
    }

    enum networkMode {
        static let auto = "networkMode.auto"
        static let only2G = "networkMode.only2G"
        static let only3G = "networkMode.only3G"
        static let only4G = "networkMode.only4G"
        static let auto3G2G = "networkMode.auto3G2G"
        static let auto4G3G = "networkMode.auto4G3G"
        static let auto4G2G = "networkMode.auto4G2G"
    }

    enum errors {
        static let connectionFailed = "errors.connectionFailed"
        static let xmlParseFailed = "errors.xmlParseFailed"
        static let apiError = "errors.apiError"
        static let unknownApiError = "errors.unknownApiError"
        static let sessionExpired = "errors.sessionExpired"
        static let authFailed = "errors.authFailed"
        static let timeout = "errors.timeout"
        static let notConnected = "errors.notConnected"
        static let tokenExhausted = "errors.tokenExhausted"
    }
}
