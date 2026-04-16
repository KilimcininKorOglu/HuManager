import Foundation

extension Translations {
    static let greek: [String: String] = [
        // General
        "general.appName": "HuManager",
        "general.appSubtitle": "Διαχείριση μόντεμ Huawei",
        "general.connect": "Σύνδεση",
        "general.connecting": "Σύνδεση...",
        "general.disconnect": "Αποσύνδεση",
        "general.connected": "Συνδεδεμένο",
        "general.disconnected": "Αποσυνδεδεμένο",
        "general.error": "Σφάλμα",
        "general.unknownError": "Άγνωστο σφάλμα",
        "general.ok": "OK",
        "general.cancel": "Ακύρωση",
        "general.apply": "Εφαρμογή",
        "general.send": "Αποστολή",
        "general.delete": "Διαγραφή",
        "general.refresh": "Ανανέωση",
        "general.loading": "Φόρτωση...",
        "general.noData": "Χωρίς δεδομένα",
        "general.start": "Έναρξη",
        "general.stop": "Διακοπή",
        "general.live": "Ζωντανά",
        "general.yes": "Ναι",
        "general.no": "Όχι",

        // Login
        "login.modemIP": "Διεύθυνση IP μόντεμ",
        "login.username": "Όνομα χρήστη",
        "login.password": "Κωδικός",
        "login.rememberMe": "Να με θυμάσαι",

        // Sidebar
        "sidebar.dashboard": "Πίνακας",
        "sidebar.signal": "Σήμα",
        "sidebar.bands": "Κλείδωμα ζωνών",
        "sidebar.sms": "SMS",
        "sidebar.network": "Δίκτυο",
        "sidebar.traffic": "Κίνηση",
        "sidebar.wifi": "WiFi",
        "sidebar.device": "Συσκευή",

        // Dashboard
        "dashboard.title": "Πίνακας",
        "dashboard.signalQuality": "Ποιότητα σήματος",
        "dashboard.networkInfo": "Πληροφορίες δικτύου",
        "dashboard.traffic": "Κίνηση",
        "dashboard.device": "Συσκευή",
        "dashboard.waitingSignal": "Αναμονή για δεδομένα σήματος...",
        "dashboard.waitingNetwork": "Αναμονή για πληροφορίες δικτύου...",
        "dashboard.waitingTraffic": "Αναμονή για δεδομένα κίνησης...",
        "dashboard.waitingDevice": "Αναμονή για πληροφορίες συσκευής...",

        // Signal
        "signal.title": "Παρακολούθηση σήματος",
        "signal.lteMetrics": "Μετρήσεις σήματος LTE",
        "signal.nrMetrics": "Μετρήσεις σήματος 5G NR",
        "signal.rsrpHistory": "Ιστορικό RSRP",
        "signal.sinrHistory": "Ιστορικό SINR",
        "signal.waiting": "Αναμονή για δεδομένα σήματος...",
        "signal.clearHistory": "Εκκαθάριση ιστορικού",

        // Band
        "band.title": "Κλείδωμα ζωνών",
        "band.activeBand": "Ενεργή ζώνη",
        "band.networkMode": "Λειτουργία δικτύου",
        "band.lteBands": "Ζώνες LTE",
        "band.nrBands": "Ζώνες 5G NR",
        "band.selectAll": "Όλα",
        "band.selectNone": "Κανένα",
        "band.resetAuto": "Επαναφορά σε αυτόματο",

        // SMS
        "sms.title": "SMS",
        "sms.inbox": "Εισερχόμενα",
        "sms.unread": "αδιάβαστα",
        "sms.noMessages": "Κανένα μήνυμα",
        "sms.selectMessage": "Επιλέξτε μήνυμα",
        "sms.newSMS": "Νέο SMS",
        "sms.phoneNumber": "Αριθμός τηλεφώνου",
        "sms.characters": "χαρακτήρες",

        // Traffic
        "traffic.title": "Στατιστικά κίνησης",
        "traffic.currentSession": "Τρέχουσα συνεδρία",
        "traffic.total": "Σύνολο",
        "traffic.monthly": "Μηνιαία",
        "traffic.download": "Λήψη",
        "traffic.upload": "Αποστολή",
        "traffic.dlSpeed": "Ταχύτητα DL",
        "traffic.ulSpeed": "Ταχύτητα UL",
        "traffic.duration": "Διάρκεια",
        "traffic.connectTime": "Χρόνος σύνδεσης",

        // WiFi
        "wifi.title": "WiFi",
        "wifi.settings": "Ρυθμίσεις WiFi",
        "wifi.connectedDevices": "Συνδεδεμένες συσκευές",
        "wifi.noDevices": "Καμία συνδεδεμένη συσκευή",
        "wifi.ssid": "SSID",
        "wifi.status": "Κατάσταση",
        "wifi.channel": "Κανάλι",
        "wifi.security": "Ασφάλεια",
        "wifi.password": "Κωδικός",
        "wifi.maxUsers": "Μέγιστοι χρήστες",
        "wifi.automatic": "Αυτόματο",
        "wifi.enabled": "Ενεργοποιημένο",
        "wifi.disabled": "Απενεργοποιημένο",
        "wifi.deviceName": "Όνομα συσκευής",
        "wifi.ipAddress": "Διεύθυνση IP",
        "wifi.macAddress": "Διεύθυνση MAC",

        // Device
        "device.title": "Συσκευή",
        "device.info": "Πληροφορίες συσκευής",
        "device.software": "Λογισμικό",
        "device.network": "Δίκτυο",
        "device.control": "Έλεγχος συσκευής",
        "device.reboot": "Επανεκκίνηση",
        "device.rebootConfirmTitle": "Επανεκκίνηση συσκευής",
        "device.rebootConfirmMessage": "Το μόντεμ θα επανεκκινήσει. Η σύνδεση θα χαθεί.",
        "device.model": "Μοντέλο",
        "device.serialNo": "Σειριακός αρ.",
        "device.hardware": "Υλικό",
        "device.firmware": "Firmware",

        // Status
        "status.connected": "Συνδεδεμένο",
        "status.disconnected": "Αποσυνδεδεμένο",
        "status.roaming": "Περιαγωγή",
        "status.signal": "Σήμα",
        "status.battery": "Μπαταρία",
        "status.connection": "Σύνδεση",
        "status.operator": "Πάροχος",
        "status.networkType": "Τύπος δικτύου",
        "status.plmn": "PLMN",

        // Quality
        "quality.excellent": "Άριστο",
        "quality.good": "Καλό",
        "quality.fair": "Μέτριο",
        "quality.poor": "Αδύναμο",
        "quality.noSignal": "Χωρίς σήμα",

        // Network Mode
        "networkMode.auto": "Αυτόματο",
        "networkMode.only2G": "Μόνο 2G",
        "networkMode.only3G": "Μόνο 3G",
        "networkMode.only4G": "Μόνο 4G",
        "networkMode.auto3G2G": "3G/2G αυτόματο",
        "networkMode.auto4G3G": "4G/3G αυτόματο",
        "networkMode.auto4G2G": "4G/2G αυτόματο",

        // Errors
        "errors.connectionFailed": "Αποτυχία σύνδεσης: %@",
        "errors.xmlParseFailed": "Σφάλμα ανάλυσης XML: %@",
        "errors.apiError": "Σφάλμα API [%@]: %@",
        "errors.unknownApiError": "Άγνωστο σφάλμα [%@]: %@",
        "errors.sessionExpired": "Η συνεδρία έληξε",
        "errors.authFailed": "Αποτυχία ελέγχου ταυτότητας: %@",
        "errors.timeout": "Λήξη χρονικού ορίου",
        "errors.notConnected": "Δεν υπάρχει σύνδεση με το μόντεμ",
        "errors.tokenExhausted": "Το token εξαντλήθηκε, απαιτείται εκ νέου σύνδεση",
    ]
}
