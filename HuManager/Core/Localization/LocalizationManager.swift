import Foundation
import SwiftUI

@Observable
final class LocalizationManager: @unchecked Sendable {

    static let shared = LocalizationManager()

    var currentLanguage: Language {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "app_language")
        }
    }

    private init() {
        let saved = UserDefaults.standard.string(forKey: "app_language") ?? "tr"
        currentLanguage = Language(rawValue: saved) ?? .turkish
    }

    func t(_ key: String) -> String {
        guard let translations = Translations.all[currentLanguage],
              let value = translations[key] else {
            return key
        }
        return value
    }

    func t(_ key: String, _ args: CVarArg...) -> String {
        let template = t(key)
        return String(format: template, arguments: args)
    }
}

// MARK: - Environment Key

private struct LocalizationManagerKey: EnvironmentKey {
    static let defaultValue = LocalizationManager.shared
}

extension EnvironmentValues {
    var localization: LocalizationManager {
        get { self[LocalizationManagerKey.self] }
        set { self[LocalizationManagerKey.self] = newValue }
    }
}
