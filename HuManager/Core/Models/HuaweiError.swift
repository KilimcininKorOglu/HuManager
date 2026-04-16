import Foundation

enum HuaweiErrorCode: Int, Sendable {
    // System
    case noSupport = 100002
    case noRights = 100003
    case busy = 100004

    // Login
    case usernameWrong = 108001
    case passwordWrong = 108002
    case alreadyLoggedIn = 108003
    case tooManyUsers = 108005
    case usernameOrPasswordError = 108006
    case tooManyLoginAttempts = 108007
    case modifyPasswordError = 108008
    case loginDifferentDevices = 108009
    case frequentLogin = 108010

    // SIM
    case noSimCard = 101001
    case simPinLock = 101002
    case simPukLock = 101003

    // Session
    case wrongToken = 125001
    case wrongSession = 125002
    case wrongSessionToken = 125003

    // Network
    case netModeFailedDuringDialup = 112001
}

enum HuaweiAPIError: Error, LocalizedError, Sendable {
    case connectionFailed(underlying: String)
    case xmlParsingFailed(raw: String)
    case apiError(code: HuaweiErrorCode, message: String)
    case unknownAPIError(code: Int, message: String)
    case sessionExpired
    case authenticationFailed(reason: String)
    case timeout
    case notConnected
    case tokenExhausted

    var errorDescription: String? {
        let lang = LocalizationManager.shared
        switch self {
        case .connectionFailed(let underlying):
            return lang.t(L.errors.connectionFailed, underlying)
        case .xmlParsingFailed(let raw):
            return lang.t(L.errors.xmlParseFailed, String(raw.prefix(100)))
        case .apiError(let code, let message):
            return lang.t(L.errors.apiError, "\(code.rawValue)", message)
        case .unknownAPIError(let code, let message):
            return lang.t(L.errors.unknownApiError, "\(code)", message)
        case .sessionExpired:
            return lang.t(L.errors.sessionExpired)
        case .authenticationFailed(let reason):
            return lang.t(L.errors.authFailed, reason)
        case .timeout:
            return lang.t(L.errors.timeout)
        case .notConnected:
            return lang.t(L.errors.notConnected)
        case .tokenExhausted:
            return lang.t(L.errors.tokenExhausted)
        }
    }
}
