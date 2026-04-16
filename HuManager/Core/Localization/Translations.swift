import Foundation

// MARK: - Translation Dictionaries

enum Translations {

    static let all: [Language: [String: String]] = [
        .turkish: turkish,
        .english: english
    ]

    // MARK: - Turkish

    static let turkish: [String: String] = [
        // General
        "general.appName": "HuManager",
        "general.appSubtitle": "Huawei Modem Yönetimi",
        "general.connect": "Bağlan",
        "general.connecting": "Bağlanıyor...",
        "general.disconnect": "Bağlantıyı Kes",
        "general.connected": "Bağlı",
        "general.disconnected": "Bağlı Değil",
        "general.error": "Hata",
        "general.unknownError": "Bilinmeyen hata",
        "general.ok": "Tamam",
        "general.cancel": "İptal",
        "general.apply": "Uygula",
        "general.send": "Gönder",
        "general.delete": "Sil",
        "general.refresh": "Yenile",
        "general.loading": "Yükleniyor...",
        "general.noData": "Veri yok",
        "general.start": "Başlat",
        "general.stop": "Durdur",
        "general.live": "Canlı",
        "general.yes": "Evet",
        "general.no": "Hayır",

        // Login
        "login.modemIP": "Modem IP Adresi",
        "login.username": "Kullanıcı Adı",
        "login.password": "Şifre",

        // Sidebar
        "sidebar.dashboard": "Gösterge Paneli",
        "sidebar.signal": "Sinyal",
        "sidebar.bands": "Band Kilidi",
        "sidebar.sms": "SMS",
        "sidebar.network": "Ağ",
        "sidebar.traffic": "Trafik",
        "sidebar.wifi": "WiFi",
        "sidebar.device": "Cihaz",

        // Dashboard
        "dashboard.title": "Gösterge Paneli",
        "dashboard.signalQuality": "Sinyal Kalitesi",
        "dashboard.networkInfo": "Ağ Bilgisi",
        "dashboard.traffic": "Trafik",
        "dashboard.device": "Cihaz",
        "dashboard.waitingSignal": "Sinyal verisi bekleniyor...",
        "dashboard.waitingNetwork": "Ağ bilgisi bekleniyor...",
        "dashboard.waitingTraffic": "Trafik verisi bekleniyor...",
        "dashboard.waitingDevice": "Cihaz bilgisi bekleniyor...",

        // Signal
        "signal.title": "Sinyal İzleme",
        "signal.lteMetrics": "LTE Sinyal Metrikleri",
        "signal.nrMetrics": "5G NR Sinyal Metrikleri",
        "signal.rsrpHistory": "RSRP Geçmişi",
        "signal.sinrHistory": "SINR Geçmişi",
        "signal.waiting": "Sinyal verisi bekleniyor...",
        "signal.clearHistory": "Geçmişi Temizle",

        // Band
        "band.title": "Band Kilidi",
        "band.activeBand": "Aktif Band",
        "band.networkMode": "Ağ Modu",
        "band.lteBands": "LTE Bandları",
        "band.nrBands": "5G NR Bandları",
        "band.selectAll": "Tümü",
        "band.selectNone": "Hiçbiri",
        "band.resetAuto": "Otomatiğe Sıfırla",

        // SMS
        "sms.title": "SMS",
        "sms.inbox": "Gelen Kutusu",
        "sms.unread": "okunmamış",
        "sms.noMessages": "Mesaj yok",
        "sms.selectMessage": "Bir mesaj seçin",
        "sms.newSMS": "Yeni SMS",
        "sms.phoneNumber": "Telefon Numarası",
        "sms.characters": "karakter",

        // Traffic
        "traffic.title": "Trafik İstatistikleri",
        "traffic.currentSession": "Mevcut Oturum",
        "traffic.total": "Toplam",
        "traffic.monthly": "Aylık",
        "traffic.download": "İndirme",
        "traffic.upload": "Yükleme",
        "traffic.dlSpeed": "DL Hız",
        "traffic.ulSpeed": "UL Hız",
        "traffic.duration": "Süre",
        "traffic.connectTime": "Bağlantı Süresi",

        // WiFi
        "wifi.title": "WiFi",
        "wifi.settings": "WiFi Ayarları",
        "wifi.connectedDevices": "Bağlı Cihazlar",
        "wifi.noDevices": "Bağlı cihaz yok",
        "wifi.ssid": "SSID",
        "wifi.status": "Durum",
        "wifi.channel": "Kanal",
        "wifi.security": "Güvenlik",
        "wifi.password": "Şifre",
        "wifi.maxUsers": "Maks Kullanıcı",
        "wifi.automatic": "Otomatik",
        "wifi.enabled": "Açık",
        "wifi.disabled": "Kapalı",
        "wifi.deviceName": "Cihaz Adı",
        "wifi.ipAddress": "IP Adresi",
        "wifi.macAddress": "MAC Adresi",

        // Device
        "device.title": "Cihaz",
        "device.info": "Cihaz Bilgisi",
        "device.software": "Yazılım",
        "device.network": "Ağ",
        "device.control": "Cihaz Kontrolü",
        "device.reboot": "Yeniden Başlat",
        "device.rebootConfirmTitle": "Cihazı Yeniden Başlat",
        "device.rebootConfirmMessage": "Modem yeniden başlatılacak. Bağlantı kesilecektir.",
        "device.model": "Model",
        "device.serialNo": "Seri No",
        "device.hardware": "Donanım",
        "device.firmware": "Yazılım",

        // Status
        "status.connected": "Bağlı",
        "status.disconnected": "Bağlı Değil",
        "status.roaming": "Dolaşım",
        "status.signal": "Sinyal",
        "status.battery": "Pil",
        "status.connection": "Bağlantı",
        "status.operator": "Operatör",
        "status.networkType": "Ağ Türü",
        "status.plmn": "PLMN",

        // Quality
        "quality.excellent": "Mükemmel",
        "quality.good": "İyi",
        "quality.fair": "Orta",
        "quality.poor": "Zayıf",
        "quality.noSignal": "Sinyal Yok",

        // Network Mode
        "networkMode.auto": "Otomatik",
        "networkMode.only2G": "Sadece 2G",
        "networkMode.only3G": "Sadece 3G",
        "networkMode.only4G": "Sadece 4G",
        "networkMode.auto3G2G": "3G/2G Otomatik",
        "networkMode.auto4G3G": "4G/3G Otomatik",
        "networkMode.auto4G2G": "4G/2G Otomatik",

        // Errors
        "errors.connectionFailed": "Bağlantı hatası: %@",
        "errors.xmlParseFailed": "XML ayrıştırma hatası: %@",
        "errors.apiError": "API hatası [%@]: %@",
        "errors.unknownApiError": "Bilinmeyen hata [%@]: %@",
        "errors.sessionExpired": "Oturum süresi doldu",
        "errors.authFailed": "Kimlik doğrulama hatası: %@",
        "errors.timeout": "Zaman aşımı",
        "errors.notConnected": "Modem bağlantısı yok",
        "errors.tokenExhausted": "Token tükendi, yeniden giriş gerekli",
    ]

    // MARK: - English

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
