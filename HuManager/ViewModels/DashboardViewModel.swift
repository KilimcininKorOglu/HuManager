import Foundation

@MainActor @Observable
final class DashboardViewModel {
    var deviceInfo: DeviceInfo?
    var signalInfo: SignalInfo?
    var networkInfo: NetworkInfo?
    var monitoringStatus: MonitoringStatus?
    var trafficStats: TrafficStatistics?
    var isLoading = false
    var errorMessage: String?

    private let deviceService = DeviceService()

    func loadAll(client: HuaweiAPIClient) async {
        isLoading = true
        errorMessage = nil

        async let device = deviceService.getDeviceInfo(client: client)
        async let signal = deviceService.getSignal(client: client)
        async let network = deviceService.getNetworkInfo(client: client)
        async let monitoring = deviceService.getMonitoringStatus(client: client)
        async let traffic = deviceService.getTrafficStatistics(client: client)

        do {
            deviceInfo = try await device
            signalInfo = try await signal
            networkInfo = try await network
            monitoringStatus = try await monitoring
            trafficStats = try await traffic
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
