import Foundation
import os

final class DeviceService: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "DeviceService")

    func getDeviceInfo(client: HuaweiAPIClient) async throws -> DeviceInfo {
        let response = try await client.get(Endpoints.deviceInfo)
        return DeviceInfo(from: response)
    }

    func getSignal(client: HuaweiAPIClient) async throws -> SignalInfo {
        let response = try await client.get(Endpoints.deviceSignal)
        return SignalInfo(from: response)
    }

    func getMonitoringStatus(client: HuaweiAPIClient) async throws -> MonitoringStatus {
        let response = try await client.get(Endpoints.monitoringStatus)
        return MonitoringStatus(from: response)
    }

    func getNetworkInfo(client: HuaweiAPIClient) async throws -> NetworkInfo {
        let response = try await client.get(Endpoints.currentPLMN)
        return NetworkInfo(from: response)
    }

    func getTrafficStatistics(client: HuaweiAPIClient) async throws -> TrafficStatistics {
        let response = try await client.get(Endpoints.trafficStatistics)
        return TrafficStatistics(from: response)
    }

    func reboot(client: HuaweiAPIClient) async throws {
        let body = XMLRequestBuilder.buildOrdered(elements: [("Control", "1")])
        _ = try await client.post(Endpoints.deviceControl, body: body)
        logger.info("Modem yeniden başlatma komutu gönderildi")
    }
}
