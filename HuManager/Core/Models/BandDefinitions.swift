import Foundation

// MARK: - LTE Bands

enum LTEBand: Int, CaseIterable, Identifiable, Sendable {
    case b1 = 1
    case b2 = 2
    case b3 = 3
    case b4 = 4
    case b5 = 5
    case b7 = 7
    case b8 = 8
    case b12 = 12
    case b13 = 13
    case b17 = 17
    case b18 = 18
    case b19 = 19
    case b20 = 20
    case b21 = 21
    case b25 = 25
    case b26 = 26
    case b28 = 28
    case b29 = 29
    case b30 = 30
    case b32 = 32
    case b34 = 34
    case b38 = 38
    case b39 = 39
    case b40 = 40
    case b41 = 41
    case b42 = 42
    case b43 = 43

    var id: Int { rawValue }

    var name: String { "B\(rawValue)" }

    var frequency: String {
        switch self {
        case .b1: "2100 MHz"
        case .b2: "1900 MHz"
        case .b3: "1800 MHz"
        case .b4: "1700/2100 MHz"
        case .b5: "850 MHz"
        case .b7: "2600 MHz"
        case .b8: "900 MHz"
        case .b12: "700 MHz"
        case .b13: "700 MHz"
        case .b17: "700 MHz"
        case .b18: "850 MHz"
        case .b19: "850 MHz"
        case .b20: "800 MHz"
        case .b21: "1500 MHz"
        case .b25: "1900 MHz"
        case .b26: "850 MHz"
        case .b28: "700 MHz"
        case .b29: "700 MHz"
        case .b30: "2300 MHz"
        case .b32: "1500 MHz"
        case .b34: "2000 MHz"
        case .b38: "2600 MHz"
        case .b39: "1900 MHz"
        case .b40: "2300 MHz"
        case .b41: "2500 MHz"
        case .b42: "3500 MHz"
        case .b43: "3700 MHz"
        }
    }

    /// Bitmask: B1 = bit 0, B3 = bit 2, etc.
    var bitmask: UInt64 {
        1 << UInt64(rawValue - 1)
    }
}

// MARK: - 5G NR Bands

enum NRBand: Int, CaseIterable, Identifiable, Sendable {
    case n1 = 1
    case n3 = 3
    case n5 = 5
    case n7 = 7
    case n8 = 8
    case n20 = 20
    case n28 = 28
    case n38 = 38
    case n40 = 40
    case n41 = 41
    case n77 = 77
    case n78 = 78
    case n79 = 79

    var id: Int { rawValue }

    var name: String { "n\(rawValue)" }

    var frequency: String {
        switch self {
        case .n1: "2100 MHz"
        case .n3: "1800 MHz"
        case .n5: "850 MHz"
        case .n7: "2600 MHz"
        case .n8: "900 MHz"
        case .n20: "800 MHz"
        case .n28: "700 MHz"
        case .n38: "2600 MHz"
        case .n40: "2300 MHz"
        case .n41: "2500 MHz"
        case .n77: "3300-4200 MHz"
        case .n78: "3300-3800 MHz"
        case .n79: "4400-5000 MHz"
        }
    }

    /// NR band bitmask — same formula: bit (N-1)
    var bitmaskHigh: UInt64 {
        if rawValue <= 64 {
            return 0
        }
        return 1 << UInt64(rawValue - 65)
    }

    var bitmaskLow: UInt64 {
        if rawValue > 64 {
            return 0
        }
        return 1 << UInt64(rawValue - 1)
    }
}

// MARK: - Network Mode

enum NetworkMode: String, CaseIterable, Identifiable, Sendable {
    case auto = "00"
    case only2G = "01"
    case only3G = "02"
    case only4G = "03"
    case auto3G2G = "0201"
    case auto4G3G = "0302"
    case auto4G2G = "0301"

    var id: String { rawValue }

    var displayName: String {
        let lang = LocalizationManager.shared
        switch self {
        case .auto: return lang.t(L.networkMode.auto)
        case .only2G: return lang.t(L.networkMode.only2G)
        case .only3G: return lang.t(L.networkMode.only3G)
        case .only4G: return lang.t(L.networkMode.only4G)
        case .auto3G2G: return lang.t(L.networkMode.auto3G2G)
        case .auto4G3G: return lang.t(L.networkMode.auto4G3G)
        case .auto4G2G: return lang.t(L.networkMode.auto4G2G)
        }
    }
}
