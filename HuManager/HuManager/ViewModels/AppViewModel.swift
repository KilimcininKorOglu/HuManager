import Foundation
import SwiftUI

enum ConnectionState: Sendable {
    case disconnected
    case connecting
    case connected
    case error(String)
}

enum SidebarTab: String, CaseIterable, Identifiable {
    case dashboard = "Gösterge Paneli"
    case signal = "Sinyal"
    case bands = "Band Kilidi"
    case sms = "SMS"
    case network = "Ağ"
    case traffic = "Trafik"
    case wifi = "WiFi"
    case device = "Cihaz"

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

    private(set) var apiClient: HuaweiAPIClient?

    var isConnected: Bool {
        if case .connected = connectionState { return true }
        return false
    }

    func connect() async {
        connectionState = .connecting

        let client = HuaweiAPIClient(host: modemIP)
        apiClient = client

        do {
            let _ = try await client.get(Endpoints.stateLogin)
            connectionState = .connected
        } catch {
            connectionState = .error(error.localizedDescription)
            errorMessage = error.localizedDescription
            showError = true
        }
    }

    func disconnect() {
        apiClient = nil
        connectionState = .disconnected
    }
}
