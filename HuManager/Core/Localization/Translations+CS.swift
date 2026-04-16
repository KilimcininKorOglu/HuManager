import Foundation

extension Translations {
    static let czech: [String: String] = [
        // General
        "general.appName": "HuManager",
        "general.appSubtitle": "Správce modemů Huawei",
        "general.connect": "Připojit",
        "general.connecting": "Připojování...",
        "general.disconnect": "Odpojit",
        "general.connected": "Připojeno",
        "general.disconnected": "Odpojeno",
        "general.error": "Chyba",
        "general.unknownError": "Neznámá chyba",
        "general.ok": "OK",
        "general.cancel": "Zrušit",
        "general.apply": "Použít",
        "general.send": "Odeslat",
        "general.delete": "Smazat",
        "general.refresh": "Obnovit",
        "general.loading": "Načítání...",
        "general.noData": "Žádná data",
        "general.start": "Spustit",
        "general.stop": "Zastavit",
        "general.live": "Živě",
        "general.yes": "Ano",
        "general.no": "Ne",

        // Login
        "login.modemIP": "IP adresa modemu",
        "login.username": "Uživatelské jméno",
        "login.password": "Heslo",

        // Sidebar
        "sidebar.dashboard": "Přehled",
        "sidebar.signal": "Signál",
        "sidebar.bands": "Zámek pásem",
        "sidebar.sms": "SMS",
        "sidebar.network": "Síť",
        "sidebar.traffic": "Provoz",
        "sidebar.wifi": "WiFi",
        "sidebar.device": "Zařízení",

        // Dashboard
        "dashboard.title": "Přehled",
        "dashboard.signalQuality": "Kvalita signálu",
        "dashboard.networkInfo": "Informace o síti",
        "dashboard.traffic": "Provoz",
        "dashboard.device": "Zařízení",
        "dashboard.waitingSignal": "Čekání na data signálu...",
        "dashboard.waitingNetwork": "Čekání na informace o síti...",
        "dashboard.waitingTraffic": "Čekání na data provozu...",
        "dashboard.waitingDevice": "Čekání na informace o zařízení...",

        // Signal
        "signal.title": "Monitorování signálu",
        "signal.lteMetrics": "Metriky signálu LTE",
        "signal.nrMetrics": "Metriky signálu 5G NR",
        "signal.rsrpHistory": "Historie RSRP",
        "signal.sinrHistory": "Historie SINR",
        "signal.waiting": "Čekání na data signálu...",
        "signal.clearHistory": "Vymazat historii",

        // Band
        "band.title": "Zámek pásem",
        "band.activeBand": "Aktivní pásmo",
        "band.networkMode": "Režim sítě",
        "band.lteBands": "Pásma LTE",
        "band.nrBands": "Pásma 5G NR",
        "band.selectAll": "Vše",
        "band.selectNone": "Nic",
        "band.resetAuto": "Obnovit na auto",

        // SMS
        "sms.title": "SMS",
        "sms.inbox": "Doručené",
        "sms.unread": "nepřečtené",
        "sms.noMessages": "Žádné zprávy",
        "sms.selectMessage": "Vyberte zprávu",
        "sms.newSMS": "Nová SMS",
        "sms.phoneNumber": "Telefonní číslo",
        "sms.characters": "znaků",

        // Traffic
        "traffic.title": "Statistiky provozu",
        "traffic.currentSession": "Aktuální relace",
        "traffic.total": "Celkem",
        "traffic.monthly": "Měsíční",
        "traffic.download": "Stahování",
        "traffic.upload": "Odesílání",
        "traffic.dlSpeed": "Rychlost DL",
        "traffic.ulSpeed": "Rychlost UL",
        "traffic.duration": "Doba trvání",
        "traffic.connectTime": "Doba připojení",

        // WiFi
        "wifi.title": "WiFi",
        "wifi.settings": "Nastavení WiFi",
        "wifi.connectedDevices": "Připojená zařízení",
        "wifi.noDevices": "Žádná připojená zařízení",
        "wifi.ssid": "SSID",
        "wifi.status": "Stav",
        "wifi.channel": "Kanál",
        "wifi.security": "Zabezpečení",
        "wifi.password": "Heslo",
        "wifi.maxUsers": "Max uživatelů",
        "wifi.automatic": "Automaticky",
        "wifi.enabled": "Zapnuto",
        "wifi.disabled": "Vypnuto",
        "wifi.deviceName": "Název zařízení",
        "wifi.ipAddress": "IP adresa",
        "wifi.macAddress": "MAC adresa",

        // Device
        "device.title": "Zařízení",
        "device.info": "Informace o zařízení",
        "device.software": "Software",
        "device.network": "Síť",
        "device.control": "Ovládání zařízení",
        "device.reboot": "Restartovat",
        "device.rebootConfirmTitle": "Restartovat zařízení",
        "device.rebootConfirmMessage": "Modem se restartuje. Připojení bude ztraceno.",
        "device.model": "Model",
        "device.serialNo": "Sériové číslo",
        "device.hardware": "Hardware",
        "device.firmware": "Firmware",

        // Status
        "status.connected": "Připojeno",
        "status.disconnected": "Odpojeno",
        "status.roaming": "Roaming",
        "status.signal": "Signál",
        "status.battery": "Baterie",
        "status.connection": "Připojení",
        "status.operator": "Operátor",
        "status.networkType": "Typ sítě",
        "status.plmn": "PLMN",

        // Quality
        "quality.excellent": "Vynikající",
        "quality.good": "Dobrý",
        "quality.fair": "Přijatelný",
        "quality.poor": "Slabý",
        "quality.noSignal": "Žádný signál",

        // Network Mode
        "networkMode.auto": "Automaticky",
        "networkMode.only2G": "Pouze 2G",
        "networkMode.only3G": "Pouze 3G",
        "networkMode.only4G": "Pouze 4G",
        "networkMode.auto3G2G": "3G/2G auto",
        "networkMode.auto4G3G": "4G/3G auto",
        "networkMode.auto4G2G": "4G/2G auto",

        // Errors
        "errors.connectionFailed": "Připojení selhalo: %@",
        "errors.xmlParseFailed": "Chyba parsování XML: %@",
        "errors.apiError": "Chyba API [%@]: %@",
        "errors.unknownApiError": "Neznámá chyba [%@]: %@",
        "errors.sessionExpired": "Relace vypršela",
        "errors.authFailed": "Ověření selhalo: %@",
        "errors.timeout": "Časový limit",
        "errors.notConnected": "Nepřipojeno k modemu",
        "errors.tokenExhausted": "Token vyčerpán, nutné opětovné přihlášení",
    ]
}
