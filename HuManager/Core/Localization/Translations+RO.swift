import Foundation

extension Translations {
    static let romanian: [String: String] = [
        // General
        "general.appName": "HuManager",
        "general.appSubtitle": "Manager modem Huawei",
        "general.connect": "Conectare",
        "general.connecting": "Se conectează...",
        "general.disconnect": "Deconectare",
        "general.connected": "Conectat",
        "general.disconnected": "Deconectat",
        "general.error": "Eroare",
        "general.unknownError": "Eroare necunoscută",
        "general.ok": "OK",
        "general.cancel": "Anulare",
        "general.apply": "Aplică",
        "general.send": "Trimite",
        "general.delete": "Șterge",
        "general.refresh": "Reîmprospătare",
        "general.loading": "Se încarcă...",
        "general.noData": "Fără date",
        "general.start": "Pornire",
        "general.stop": "Oprire",
        "general.live": "Live",
        "general.yes": "Da",
        "general.no": "Nu",

        // Login
        "login.modemIP": "Adresa IP a modemului",
        "login.username": "Utilizator",
        "login.password": "Parolă",
        "login.rememberMe": "Ține-mă minte",

        // Sidebar
        "sidebar.dashboard": "Panou",
        "sidebar.signal": "Semnal",
        "sidebar.bands": "Blocare benzi",
        "sidebar.sms": "SMS",
        "sidebar.network": "Rețea",
        "sidebar.traffic": "Trafic",
        "sidebar.wifi": "WiFi",
        "sidebar.device": "Dispozitiv",

        // Dashboard
        "dashboard.title": "Panou",
        "dashboard.signalQuality": "Calitate semnal",
        "dashboard.networkInfo": "Informații rețea",
        "dashboard.traffic": "Trafic",
        "dashboard.device": "Dispozitiv",
        "dashboard.waitingSignal": "Se așteaptă datele semnalului...",
        "dashboard.waitingNetwork": "Se așteaptă informațiile rețelei...",
        "dashboard.waitingTraffic": "Se așteaptă datele de trafic...",
        "dashboard.waitingDevice": "Se așteaptă informațiile dispozitivului...",

        // Signal
        "signal.title": "Monitorizare semnal",
        "signal.lteMetrics": "Metrici semnal LTE",
        "signal.nrMetrics": "Metrici semnal 5G NR",
        "signal.rsrpHistory": "Istoric RSRP",
        "signal.sinrHistory": "Istoric SINR",
        "signal.waiting": "Se așteaptă datele semnalului...",
        "signal.clearHistory": "Șterge istoricul",

        // Band
        "band.title": "Blocare benzi",
        "band.activeBand": "Bandă activă",
        "band.networkMode": "Mod rețea",
        "band.lteBands": "Benzi LTE",
        "band.nrBands": "Benzi 5G NR",
        "band.selectAll": "Toate",
        "band.selectNone": "Niciuna",
        "band.resetAuto": "Resetare la auto",

        // SMS
        "sms.title": "SMS",
        "sms.inbox": "Primite",
        "sms.unread": "necitite",
        "sms.noMessages": "Niciun mesaj",
        "sms.selectMessage": "Selectați un mesaj",
        "sms.newSMS": "SMS nou",
        "sms.phoneNumber": "Număr de telefon",
        "sms.characters": "caractere",

        // Traffic
        "traffic.title": "Statistici trafic",
        "traffic.currentSession": "Sesiune curentă",
        "traffic.total": "Total",
        "traffic.monthly": "Lunar",
        "traffic.download": "Descărcare",
        "traffic.upload": "Încărcare",
        "traffic.dlSpeed": "Viteză DL",
        "traffic.ulSpeed": "Viteză UL",
        "traffic.duration": "Durată",
        "traffic.connectTime": "Timp de conectare",

        // WiFi
        "wifi.title": "WiFi",
        "wifi.settings": "Setări WiFi",
        "wifi.connectedDevices": "Dispozitive conectate",
        "wifi.noDevices": "Niciun dispozitiv conectat",
        "wifi.ssid": "SSID",
        "wifi.status": "Stare",
        "wifi.channel": "Canal",
        "wifi.security": "Securitate",
        "wifi.password": "Parolă",
        "wifi.maxUsers": "Utilizatori max",
        "wifi.automatic": "Automat",
        "wifi.enabled": "Activat",
        "wifi.disabled": "Dezactivat",
        "wifi.deviceName": "Nume dispozitiv",
        "wifi.ipAddress": "Adresă IP",
        "wifi.macAddress": "Adresă MAC",

        // Device
        "device.title": "Dispozitiv",
        "device.info": "Informații dispozitiv",
        "device.software": "Software",
        "device.network": "Rețea",
        "device.control": "Control dispozitiv",
        "device.reboot": "Repornire",
        "device.rebootConfirmTitle": "Repornire dispozitiv",
        "device.rebootConfirmMessage": "Modemul va reporni. Conexiunea va fi pierdută.",
        "device.model": "Model",
        "device.serialNo": "Nr. serie",
        "device.hardware": "Hardware",
        "device.firmware": "Firmware",

        // Status
        "status.connected": "Conectat",
        "status.disconnected": "Deconectat",
        "status.roaming": "Roaming",
        "status.signal": "Semnal",
        "status.battery": "Baterie",
        "status.connection": "Conexiune",
        "status.operator": "Operator",
        "status.networkType": "Tip rețea",
        "status.plmn": "PLMN",

        // Quality
        "quality.excellent": "Excelent",
        "quality.good": "Bun",
        "quality.fair": "Acceptabil",
        "quality.poor": "Slab",
        "quality.noSignal": "Fără semnal",

        // Network Mode
        "networkMode.auto": "Automat",
        "networkMode.only2G": "Doar 2G",
        "networkMode.only3G": "Doar 3G",
        "networkMode.only4G": "Doar 4G",
        "networkMode.auto3G2G": "3G/2G auto",
        "networkMode.auto4G3G": "4G/3G auto",
        "networkMode.auto4G2G": "4G/2G auto",

        // Errors
        "errors.connectionFailed": "Conectare eșuată: %@",
        "errors.xmlParseFailed": "Eroare parsare XML: %@",
        "errors.apiError": "Eroare API [%@]: %@",
        "errors.unknownApiError": "Eroare necunoscută [%@]: %@",
        "errors.sessionExpired": "Sesiune expirată",
        "errors.authFailed": "Autentificare eșuată: %@",
        "errors.timeout": "Timp expirat",
        "errors.notConnected": "Neconectat la modem",
        "errors.tokenExhausted": "Token epuizat, reconectare necesară",
    ]
}
