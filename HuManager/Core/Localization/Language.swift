import Foundation

enum Language: String, CaseIterable, Identifiable, Sendable {
    case turkish = "tr"
    case english = "en"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .turkish: "Turkce"
        case .english: "English"
        }
    }

    var flag: String {
        switch self {
        case .turkish: "🇹🇷"
        case .english: "🇬🇧"
        }
    }

    var shortLabel: String {
        switch self {
        case .turkish: "TR"
        case .english: "EN"
        }
    }
}
