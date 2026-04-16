import Foundation

extension Translations {
    static let english: [String: String] = [
        // General
        "general.appName": "HuManager",
        "general.appSubtitle": "Huawei Modem Manager",
        "general.connect": "Connect",
        "general.connecting": "Connecting...",
        "general.disconnect": "Disconnect",
        "general.connected": "Connected",
        "general.disconnected": "Disconnected",
        "general.error": "Error",
        "general.unknownError": "Unknown error",
        "general.ok": "OK",
        "general.cancel": "Cancel",
        "general.apply": "Apply",
        "general.send": "Send",
        "general.delete": "Delete",
        "general.refresh": "Refresh",
        "general.loading": "Loading...",
        "general.noData": "No data",
        "general.start": "Start",
        "general.stop": "Stop",
        "general.live": "Live",
        "general.yes": "Yes",
        "general.no": "No",

        // Login
        "login.modemIP": "Modem IP Address",
        "login.username": "Username",
        "login.password": "Password",

        // Sidebar
        "sidebar.dashboard": "Dashboard",
        "sidebar.signal": "Signal",
        "sidebar.bands": "Band Lock",
        "sidebar.sms": "SMS",
        "sidebar.network": "Network",
        "sidebar.traffic": "Traffic",
        "sidebar.wifi": "WiFi",
        "sidebar.device": "Device",

        // Dashboard
        "dashboard.title": "Dashboard",
        "dashboard.signalQuality": "Signal Quality",
        "dashboard.networkInfo": "Network Info",
        "dashboard.traffic": "Traffic",
        "dashboard.device": "Device",
        "dashboard.waitingSignal": "Waiting for signal data...",
        "dashboard.waitingNetwork": "Waiting for network info...",
        "dashboard.waitingTraffic": "Waiting for traffic data...",
        "dashboard.waitingDevice": "Waiting for device info...",

        // Signal
        "signal.title": "Signal Monitoring",
        "signal.lteMetrics": "LTE Signal Metrics",
        "signal.nrMetrics": "5G NR Signal Metrics",
        "signal.rsrpHistory": "RSRP History",
        "signal.sinrHistory": "SINR History",
        "signal.waiting": "Waiting for signal data...",
        "signal.clearHistory": "Clear History",

        // Band
        "band.title": "Band Lock",
        "band.activeBand": "Active Band",
        "band.networkMode": "Network Mode",
        "band.lteBands": "LTE Bands",
        "band.nrBands": "5G NR Bands",
        "band.selectAll": "All",
        "band.selectNone": "None",
        "band.resetAuto": "Reset to Auto",

        // SMS
        "sms.title": "SMS",
        "sms.inbox": "Inbox",
        "sms.unread": "unread",
        "sms.noMessages": "No messages",
        "sms.selectMessage": "Select a message",
        "sms.newSMS": "New SMS",
        "sms.phoneNumber": "Phone Number",
        "sms.characters": "characters",

        // Traffic
        "traffic.title": "Traffic Statistics",
        "traffic.currentSession": "Current Session",
        "traffic.total": "Total",
        "traffic.monthly": "Monthly",
        "traffic.download": "Download",
        "traffic.upload": "Upload",
        "traffic.dlSpeed": "DL Speed",
        "traffic.ulSpeed": "UL Speed",
        "traffic.duration": "Duration",
        "traffic.connectTime": "Connection Time",

        // WiFi
        "wifi.title": "WiFi",
        "wifi.settings": "WiFi Settings",
        "wifi.connectedDevices": "Connected Devices",
        "wifi.noDevices": "No connected devices",
        "wifi.ssid": "SSID",
        "wifi.status": "Status",
        "wifi.channel": "Channel",
        "wifi.security": "Security",
        "wifi.password": "Password",
        "wifi.maxUsers": "Max Users",
        "wifi.automatic": "Automatic",
        "wifi.enabled": "Enabled",
        "wifi.disabled": "Disabled",
        "wifi.deviceName": "Device Name",
        "wifi.ipAddress": "IP Address",
        "wifi.macAddress": "MAC Address",

        // Device
        "device.title": "Device",
        "device.info": "Device Info",
        "device.software": "Software",
        "device.network": "Network",
        "device.control": "Device Control",
        "device.reboot": "Reboot",
        "device.rebootConfirmTitle": "Reboot Device",
        "device.rebootConfirmMessage": "The modem will restart. Connection will be lost.",
        "device.model": "Model",
        "device.serialNo": "Serial No",
        "device.hardware": "Hardware",
        "device.firmware": "Firmware",

        // Status
        "status.connected": "Connected",
        "status.disconnected": "Disconnected",
        "status.roaming": "Roaming",
        "status.signal": "Signal",
        "status.battery": "Battery",
        "status.connection": "Connection",
        "status.operator": "Operator",
        "status.networkType": "Network Type",
        "status.plmn": "PLMN",

        // Quality
        "quality.excellent": "Excellent",
        "quality.good": "Good",
        "quality.fair": "Fair",
        "quality.poor": "Poor",
        "quality.noSignal": "No Signal",

        // Network Mode
        "networkMode.auto": "Automatic",
        "networkMode.only2G": "2G Only",
        "networkMode.only3G": "3G Only",
        "networkMode.only4G": "4G Only",
        "networkMode.auto3G2G": "3G/2G Auto",
        "networkMode.auto4G3G": "4G/3G Auto",
        "networkMode.auto4G2G": "4G/2G Auto",

        // Errors
        "errors.connectionFailed": "Connection failed: %@",
        "errors.xmlParseFailed": "XML parsing error: %@",
        "errors.apiError": "API error [%@]: %@",
        "errors.unknownApiError": "Unknown error [%@]: %@",
        "errors.sessionExpired": "Session expired",
        "errors.authFailed": "Authentication failed: %@",
        "errors.timeout": "Timeout",
        "errors.notConnected": "Not connected to modem",
        "errors.tokenExhausted": "Token exhausted, re-login required",
    ]
}
