import Foundation

extension Translations {
    static let hungarian: [String: String] = [
        // General
        "general.appName": "HuManager",
        "general.appSubtitle": "Huawei modem kezelő",
        "general.connect": "Csatlakozás",
        "general.connecting": "Csatlakozás...",
        "general.disconnect": "Leválasztás",
        "general.connected": "Csatlakozva",
        "general.disconnected": "Leválasztva",
        "general.error": "Hiba",
        "general.unknownError": "Ismeretlen hiba",
        "general.ok": "OK",
        "general.cancel": "Mégse",
        "general.apply": "Alkalmaz",
        "general.send": "Küldés",
        "general.delete": "Törlés",
        "general.refresh": "Frissítés",
        "general.loading": "Betöltés...",
        "general.noData": "Nincs adat",
        "general.start": "Indítás",
        "general.stop": "Leállítás",
        "general.live": "Élő",
        "general.yes": "Igen",
        "general.no": "Nem",

        // Login
        "login.modemIP": "Modem IP-cím",
        "login.username": "Felhasználónév",
        "login.password": "Jelszó",

        // Sidebar
        "sidebar.dashboard": "Áttekintés",
        "sidebar.signal": "Jel",
        "sidebar.bands": "Sávzár",
        "sidebar.sms": "SMS",
        "sidebar.network": "Hálózat",
        "sidebar.traffic": "Forgalom",
        "sidebar.wifi": "WiFi",
        "sidebar.device": "Eszköz",

        // Dashboard
        "dashboard.title": "Áttekintés",
        "dashboard.signalQuality": "Jelminőség",
        "dashboard.networkInfo": "Hálózati adatok",
        "dashboard.traffic": "Forgalom",
        "dashboard.device": "Eszköz",
        "dashboard.waitingSignal": "Várakozás a jeladatokra...",
        "dashboard.waitingNetwork": "Várakozás a hálózati adatokra...",
        "dashboard.waitingTraffic": "Várakozás a forgalmi adatokra...",
        "dashboard.waitingDevice": "Várakozás az eszközadatokra...",

        // Signal
        "signal.title": "Jelfigyelés",
        "signal.lteMetrics": "LTE jelmutatók",
        "signal.nrMetrics": "5G NR jelmutatók",
        "signal.rsrpHistory": "RSRP előzmények",
        "signal.sinrHistory": "SINR előzmények",
        "signal.waiting": "Várakozás a jeladatokra...",
        "signal.clearHistory": "Előzmények törlése",

        // Band
        "band.title": "Sávzár",
        "band.activeBand": "Aktív sáv",
        "band.networkMode": "Hálózati mód",
        "band.lteBands": "LTE sávok",
        "band.nrBands": "5G NR sávok",
        "band.selectAll": "Mind",
        "band.selectNone": "Egyik sem",
        "band.resetAuto": "Visszaállítás automatikusra",

        // SMS
        "sms.title": "SMS",
        "sms.inbox": "Bejövő",
        "sms.unread": "olvasatlan",
        "sms.noMessages": "Nincsenek üzenetek",
        "sms.selectMessage": "Válasszon üzenetet",
        "sms.newSMS": "Új SMS",
        "sms.phoneNumber": "Telefonszám",
        "sms.characters": "karakter",

        // Traffic
        "traffic.title": "Forgalmi statisztikák",
        "traffic.currentSession": "Jelenlegi munkamenet",
        "traffic.total": "Összesen",
        "traffic.monthly": "Havi",
        "traffic.download": "Letöltés",
        "traffic.upload": "Feltöltés",
        "traffic.dlSpeed": "DL sebesség",
        "traffic.ulSpeed": "UL sebesség",
        "traffic.duration": "Időtartam",
        "traffic.connectTime": "Csatlakozási idő",

        // WiFi
        "wifi.title": "WiFi",
        "wifi.settings": "WiFi beállítások",
        "wifi.connectedDevices": "Csatlakozott eszközök",
        "wifi.noDevices": "Nincs csatlakozott eszköz",
        "wifi.ssid": "SSID",
        "wifi.status": "Állapot",
        "wifi.channel": "Csatorna",
        "wifi.security": "Biztonság",
        "wifi.password": "Jelszó",
        "wifi.maxUsers": "Max felhasználók",
        "wifi.automatic": "Automatikus",
        "wifi.enabled": "Engedélyezve",
        "wifi.disabled": "Letiltva",
        "wifi.deviceName": "Eszköznév",
        "wifi.ipAddress": "IP-cím",
        "wifi.macAddress": "MAC-cím",

        // Device
        "device.title": "Eszköz",
        "device.info": "Eszközadatok",
        "device.software": "Szoftver",
        "device.network": "Hálózat",
        "device.control": "Eszközvezérlés",
        "device.reboot": "Újraindítás",
        "device.rebootConfirmTitle": "Eszköz újraindítása",
        "device.rebootConfirmMessage": "A modem újraindul. A kapcsolat megszakad.",
        "device.model": "Modell",
        "device.serialNo": "Sorozatszám",
        "device.hardware": "Hardver",
        "device.firmware": "Firmware",

        // Status
        "status.connected": "Csatlakozva",
        "status.disconnected": "Leválasztva",
        "status.roaming": "Roaming",
        "status.signal": "Jel",
        "status.battery": "Akkumulátor",
        "status.connection": "Kapcsolat",
        "status.operator": "Szolgáltató",
        "status.networkType": "Hálózat típusa",
        "status.plmn": "PLMN",

        // Quality
        "quality.excellent": "Kiváló",
        "quality.good": "Jó",
        "quality.fair": "Közepes",
        "quality.poor": "Gyenge",
        "quality.noSignal": "Nincs jel",

        // Network Mode
        "networkMode.auto": "Automatikus",
        "networkMode.only2G": "Csak 2G",
        "networkMode.only3G": "Csak 3G",
        "networkMode.only4G": "Csak 4G",
        "networkMode.auto3G2G": "3G/2G auto",
        "networkMode.auto4G3G": "4G/3G auto",
        "networkMode.auto4G2G": "4G/2G auto",

        // Errors
        "errors.connectionFailed": "Csatlakozás sikertelen: %@",
        "errors.xmlParseFailed": "XML feldolgozási hiba: %@",
        "errors.apiError": "API hiba [%@]: %@",
        "errors.unknownApiError": "Ismeretlen hiba [%@]: %@",
        "errors.sessionExpired": "Munkamenet lejárt",
        "errors.authFailed": "Hitelesítés sikertelen: %@",
        "errors.timeout": "Időtúllépés",
        "errors.notConnected": "Nincs kapcsolat a modemmel",
        "errors.tokenExhausted": "Token kimerült, újbóli bejelentkezés szükséges",
    ]
}
