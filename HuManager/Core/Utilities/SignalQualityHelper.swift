import SwiftUI

enum SignalQuality: Sendable {
    case excellent
    case good
    case fair
    case poor
    case noSignal

    var color: Color {
        switch self {
        case .excellent: .green
        case .good: .blue
        case .fair: .yellow
        case .poor: .orange
        case .noSignal: .red
        }
    }

    var label: String {
        switch self {
        case .excellent: "Mükemmel"
        case .good: "İyi"
        case .fair: "Orta"
        case .poor: "Zayıf"
        case .noSignal: "Sinyal Yok"
        }
    }
}

enum SignalQualityHelper {

    static func rsrpQuality(_ value: Double) -> SignalQuality {
        switch value {
        case (-80.0)...: .excellent
        case -90.0..<(-80.0): .good
        case -100.0..<(-90.0): .fair
        case -110.0..<(-100.0): .poor
        default: .noSignal
        }
    }

    static func sinrQuality(_ value: Double) -> SignalQuality {
        switch value {
        case 20.0...: .excellent
        case 13.0..<20.0: .good
        case 0.0..<13.0: .fair
        case (-5.0)..<0.0: .poor
        default: .noSignal
        }
    }

    static func rsrqQuality(_ value: Double) -> SignalQuality {
        switch value {
        case (-5.0)...: .excellent
        case -10.0..<(-5.0): .good
        case -15.0..<(-10.0): .fair
        case -20.0..<(-15.0): .poor
        default: .noSignal
        }
    }

    static func rssiQuality(_ value: Double) -> SignalQuality {
        switch value {
        case (-65.0)...: .excellent
        case -75.0..<(-65.0): .good
        case -85.0..<(-75.0): .fair
        case -95.0..<(-85.0): .poor
        default: .noSignal
        }
    }
}
