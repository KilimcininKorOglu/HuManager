import Foundation

enum Language: String, CaseIterable, Identifiable, Sendable {
    case turkish = "tr"
    case english = "en"
    case german = "de"
    case french = "fr"
    case italian = "it"
    case portuguese = "pt"
    case dutch = "nl"
    case spanish = "es"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .turkish: "Türkçe"
        case .english: "English"
        case .german: "Deutsch"
        case .french: "Français"
        case .italian: "Italiano"
        case .portuguese: "Português"
        case .dutch: "Nederlands"
        case .spanish: "Español"
        }
    }

    var flag: String {
        switch self {
        case .turkish: "🇹🇷"
        case .english: "🇬🇧"
        case .german: "🇩🇪"
        case .french: "🇫🇷"
        case .italian: "🇮🇹"
        case .portuguese: "🇵🇹"
        case .dutch: "🇳🇱"
        case .spanish: "🇪🇸"
        }
    }

    var shortLabel: String {
        switch self {
        case .turkish: "TR"
        case .english: "EN"
        case .german: "DE"
        case .french: "FR"
        case .italian: "IT"
        case .portuguese: "PT"
        case .dutch: "NL"
        case .spanish: "ES"
        }
    }
}
