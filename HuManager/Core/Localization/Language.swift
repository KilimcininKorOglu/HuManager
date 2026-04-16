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
    case russian = "ru"
    case polish = "pl"
    case swedish = "sv"
    case czech = "cs"
    case romanian = "ro"
    case hungarian = "hu"
    case greek = "el"

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
        case .russian: "Русский"
        case .polish: "Polski"
        case .swedish: "Svenska"
        case .czech: "Čeština"
        case .romanian: "Română"
        case .hungarian: "Magyar"
        case .greek: "Ελληνικά"
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
        case .russian: "🇷🇺"
        case .polish: "🇵🇱"
        case .swedish: "🇸🇪"
        case .czech: "🇨🇿"
        case .romanian: "🇷🇴"
        case .hungarian: "🇭🇺"
        case .greek: "🇬🇷"
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
        case .russian: "RU"
        case .polish: "PL"
        case .swedish: "SV"
        case .czech: "CS"
        case .romanian: "RO"
        case .hungarian: "HU"
        case .greek: "EL"
        }
    }
}
