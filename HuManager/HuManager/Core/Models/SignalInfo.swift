import Foundation

struct SignalInfo: Sendable, Identifiable {
    let id = UUID()
    let timestamp: Date

    // LTE
    let rsrp: String
    let rsrq: String
    let sinr: String
    let rssi: String
    let band: String
    let cellId: String
    let pci: String
    let dlBandwidth: String
    let ulBandwidth: String
    let earfcn: String

    // 5G NR
    let nrRSRP: String
    let nrRSRQ: String
    let nrSINR: String
    let nrBand: String
    let nrCellId: String
    let nrPCI: String

    var has5G: Bool {
        !nrRSRP.isEmpty && nrRSRP != "0"
    }

    var rsrpValue: Double? { parseDBm(rsrp) }
    var rsrqValue: Double? { parseDBm(rsrq) }
    var sinrValue: Double? { parseDBm(sinr) }
    var rssiValue: Double? { parseDBm(rssi) }
    var nrRSRPValue: Double? { parseDBm(nrRSRP) }
    var nrSINRValue: Double? { parseDBm(nrSINR) }

    init(from dict: [String: Any], timestamp: Date = Date()) {
        self.timestamp = timestamp
        rsrp = dict["rsrp"] as? String ?? ""
        rsrq = dict["rsrq"] as? String ?? ""
        sinr = dict["sinr"] as? String ?? ""
        rssi = dict["rssi"] as? String ?? ""
        band = dict["band"] as? String ?? ""
        cellId = dict["cell_id"] as? String ?? ""
        pci = dict["pci"] as? String ?? ""
        dlBandwidth = dict["dlbandwidth"] as? String ?? ""
        ulBandwidth = dict["ulbandwidth"] as? String ?? ""
        earfcn = dict["earfcn"] as? String ?? ""

        // 5G field names vary by model
        nrRSRP = dict["nr_rsrp"] as? String
            ?? dict["nrrsrp"] as? String
            ?? dict["Z5g_rsrp"] as? String
            ?? dict["nrrsrp0"] as? String
            ?? ""
        nrRSRQ = dict["nr_rsrq"] as? String
            ?? dict["nrrsrq"] as? String
            ?? dict["Z5g_rsrq"] as? String
            ?? ""
        nrSINR = dict["nr_sinr"] as? String
            ?? dict["nrsinr"] as? String
            ?? dict["Z5g_sinr"] as? String
            ?? ""
        nrBand = dict["nr_band"] as? String
            ?? dict["nrband"] as? String
            ?? ""
        nrCellId = dict["nr_cell_id"] as? String
            ?? dict["nrcellid"] as? String
            ?? ""
        nrPCI = dict["nr_pci"] as? String
            ?? dict["nrpci"] as? String
            ?? ""
    }

    private func parseDBm(_ value: String) -> Double? {
        let cleaned = value.replacingOccurrences(of: "dBm", with: "")
            .replacingOccurrences(of: "dB", with: "")
            .trimmingCharacters(in: .whitespaces)
        return Double(cleaned)
    }
}
