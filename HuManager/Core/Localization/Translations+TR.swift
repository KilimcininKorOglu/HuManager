import Foundation

extension Translations {
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
        "login.rememberMe": "Beni Hatırla",

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
}
