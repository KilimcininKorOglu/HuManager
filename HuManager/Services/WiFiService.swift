import Foundation
import os

final class WiFiService: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "WiFiService")

    func getSettings(client: HuaweiAPIClient) async throws -> WiFiSettings {
        let response = try await client.get(Endpoints.wifiSettings)
        return WiFiSettings(from: response)
    }

    // Element order matters to the modem, so both setters use buildOrdered.
    func setSSID(client: HuaweiAPIClient, ssid: String, hidden: Bool, restart: Bool) async throws {
        let body = XMLRequestBuilder.buildOrdered(elements: [
            ("WifiSsid", ssid),
            ("WifiHide", hidden ? "1" : "0"),
            ("WifiRestart", restart ? "1" : "0"),
        ])

        _ = try await client.post(Endpoints.wifiBasicSettings, body: body)
        logger.info("SSID updated")
    }

    func setSecurity(
        client: HuaweiAPIClient,
        authMode: WiFiAuthMode,
        password: String,
        encryptionMode: WiFiEncryptionMode = .mixed,
        restart: Bool = true
    ) async throws {
        let body = XMLRequestBuilder.buildOrdered(elements: [
            ("WifiAuthmode", authMode.rawValue),
            ("WifiWepKey1", ""),
            ("WifiWpaencryptionmodes", encryptionMode.rawValue),
            ("WifiBasicencryptionmodes", "NONE"),
            ("WifiWpapsk", password),
            ("WifiRestart", restart ? "1" : "0"),
        ])

        _ = try await client.post(Endpoints.wifiSecuritySettings, body: body)
        logger.info("WiFi security settings updated")
    }

    func setWiFiEnabled(client: HuaweiAPIClient, enabled: Bool) async throws {
        let body = XMLRequestBuilder.build(elements: ["WifiStatus": enabled ? "1" : "0"])
        _ = try await client.post(Endpoints.wifiSwitch, body: body)
        logger.info("WiFi radio switched to \(enabled ? "on" : "off")")
    }

    func getConnectedDevices(client: HuaweiAPIClient) async throws -> [ConnectedDevice] {
        let response = try await client.get(Endpoints.connectedDevices)

        guard let hostsRaw = response["Hosts"] as? [String: Any] else {
            return []
        }

        if let hostArray = hostsRaw["Host"] as? [[String: Any]] {
            return hostArray.map { ConnectedDevice(from: $0) }
        } else if let singleHost = hostsRaw["Host"] as? [String: Any] {
            return [ConnectedDevice(from: singleHost)]
        }

        return []
    }
}
