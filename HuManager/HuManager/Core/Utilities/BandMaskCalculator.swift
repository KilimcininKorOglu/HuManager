import Foundation

enum BandMaskCalculator {

    // MARK: - LTE

    static func lteMask(from bands: Set<LTEBand>) -> String {
        let mask = bands.reduce(UInt64(0)) { $0 | $1.bitmask }
        return String(mask, radix: 16, uppercase: true)
    }

    static func lteBands(from hexMask: String) -> Set<LTEBand> {
        guard let mask = UInt64(hexMask, radix: 16) else { return [] }
        return Set(LTEBand.allCases.filter { mask & $0.bitmask != 0 })
    }

    static let lteAllMask: String = {
        let mask = LTEBand.allCases.reduce(UInt64(0)) { $0 | $1.bitmask }
        return String(mask, radix: 16, uppercase: true)
    }()

    static func isAutoLTE(_ hexMask: String) -> Bool {
        guard let mask = UInt64(hexMask, radix: 16) else { return false }
        let allBands = LTEBand.allCases.reduce(UInt64(0)) { $0 | $1.bitmask }
        return mask == allBands || hexMask.uppercased() == "7FFFFFFFFFFFFFFF"
    }

    // MARK: - NR

    static func nrMask(from bands: Set<NRBand>) -> String {
        let low = bands.reduce(UInt64(0)) { $0 | $1.bitmaskLow }
        let high = bands.reduce(UInt64(0)) { $0 | $1.bitmaskHigh }

        if high == 0 {
            return String(low, radix: 16, uppercase: true)
        }

        let highHex = String(high, radix: 16, uppercase: true)
        let lowHex = String(low, radix: 16, uppercase: true).leftPadded(toLength: 16, with: "0")
        return highHex + lowHex
    }

    static func nrBands(from hexMask: String) -> Set<NRBand> {
        let paddedHex = hexMask.count > 16 ? hexMask : hexMask
        guard let low = UInt64(String(paddedHex.suffix(16)), radix: 16) else { return [] }

        var high: UInt64 = 0
        if paddedHex.count > 16 {
            let highPart = String(paddedHex.prefix(paddedHex.count - 16))
            high = UInt64(highPart, radix: 16) ?? 0
        }

        return Set(NRBand.allCases.filter { band in
            if band.rawValue <= 64 {
                return low & band.bitmaskLow != 0
            } else {
                return high & band.bitmaskHigh != 0
            }
        })
    }
}

// MARK: - String Helper

extension String {
    func leftPadded(toLength length: Int, with character: Character) -> String {
        if count >= length { return self }
        return String(repeating: character, count: length - count) + self
    }
}
