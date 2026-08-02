import Foundation
import os

// Single source for the os.Logger subsystem so Console.app filtering
// matches the bundle identifier.
enum AppLog {

    static let subsystem = "com.KilimcininKorOglu.HuManager"

    static func logger(_ category: String) -> Logger {
        Logger(subsystem: subsystem, category: category)
    }
}
