import Foundation
import SwiftUI

enum ConnectionState: Sendable {
    case disconnected
    case connecting
    case connected
    case error(String)
}

enum SidebarTab: String, CaseIterable, Identifiable {
    case dashboard = "dashboard"
    case signal = "signal"
    case bands = "bands"
    case sms = "sms"
    case network = "network"
    case traffic = "traffic"
    case wifi = "wifi"
    case device = "device"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .dashboard: "house"
        case .signal: "antenna.radiowaves.left.and.right"
        case .bands: "slider.horizontal.3"
        case .sms: "message"
        case .network: "network"
        case .traffic: "chart.bar"
        case .wifi: "wifi"
        case .device: "cpu"
        }
    }

    func displayName(_ lang: LocalizationManager) -> String {
        switch self {
        case .dashboard: lang.t(L.sidebar.dashboard)
        case .signal: lang.t(L.sidebar.signal)
        case .bands: lang.t(L.sidebar.bands)
        case .sms: lang.t(L.sidebar.sms)
        case .network: lang.t(L.sidebar.network)
        case .traffic: lang.t(L.sidebar.traffic)
        case .wifi: lang.t(L.sidebar.wifi)
        case .device: lang.t(L.sidebar.device)
        }
    }
}

@MainActor @Observable
final class AppViewModel {
    var connectionState: ConnectionState = .disconnected
    var selectedTab: SidebarTab = .dashboard
    var errorMessage: String?
    var showError = false

    var modemIP: String = "192.168.8.1"
    var username: String = "admin"
    var password: String = ""
    var rememberMe: Bool = false

    private(set) var apiClient: HuaweiAPIClient?
    private(set) var webUIVersion: WebUIVersion?
    private let authService = AuthService()
    private let heartbeatService = HeartbeatService()

    private static let kRememberMe = "login.rememberMe"
    private static let kModemIP = "login.modemIP"
    private static let kUsername = "login.username"
    private static let kPassword = "login.password"

    init() {
        let defaults = UserDefaults.standard
        let saved = defaults.bool(forKey: Self.kRememberMe)
        rememberMe = saved
        if saved {
            modemIP = defaults.string(forKey: Self.kModemIP) ?? "192.168.8.1"
            username = defaults.string(forKey: Self.kUsername) ?? "admin"
            password = defaults.string(forKey: Self.kPassword) ?? ""
        }
    }

    var isConnected: Bool {
        if case .connected = connectionState { return true }
        return false
    }

    func connect() async {
        connectionState = .connecting
        errorMessage = nil

        let client = HuaweiAPIClient(host: modemIP)
        apiClient = client

        do {
            let result = try await authService.login(
                client: client,
                username: username,
                password: password
            )
            webUIVersion = result.version
            connectionState = .connected
            saveCredentials()
            await heartbeatService.start(client: client)
        } catch {
            connectionState = .error(error.localizedDescription)
            errorMessage = error.localizedDescription
            showError = true
            apiClient = nil
        }
    }

    private func saveCredentials() {
        let defaults = UserDefaults.standard
        defaults.set(rememberMe, forKey: Self.kRememberMe)
        if rememberMe {
            defaults.set(modemIP, forKey: Self.kModemIP)
            defaults.set(username, forKey: Self.kUsername)
            defaults.set(password, forKey: Self.kPassword)
        } else {
            defaults.removeObject(forKey: Self.kModemIP)
            defaults.removeObject(forKey: Self.kUsername)
            defaults.removeObject(forKey: Self.kPassword)
        }
    }

    func disconnect() async {
        await heartbeatService.stop()
        if let client = apiClient {
            try? await authService.logout(client: client)
        }
        apiClient = nil
        webUIVersion = nil
        connectionState = .disconnected
    }
}
