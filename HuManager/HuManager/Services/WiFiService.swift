import Foundation
import os

final class WiFiService: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "WiFiService")

    func getSettings(client: HuaweiAPIClient) async throws -> WiFiSettings {
        let response = try await client.get(Endpoints.wifiSettings)
        return WiFiSettings(from: response)
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
