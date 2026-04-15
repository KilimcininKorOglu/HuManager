import Foundation

@MainActor @Observable
final class TrafficViewModel {
    var traffic: TrafficStatistics?
    var monthStats: MonthStatistics?
    var isLoading = false
    var errorMessage: String?
    var isPolling = false

    private let deviceService = DeviceService()
    private var pollingTask: Task<Void, Never>?

    func loadTraffic(client: HuaweiAPIClient) async {
        isLoading = true
        errorMessage = nil

        do {
            traffic = try await deviceService.getTrafficStatistics(client: client)
            let monthResponse = try await client.get(Endpoints.monthStatistics)
            monthStats = MonthStatistics(from: monthResponse)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func startPolling(client: HuaweiAPIClient) {
        guard !isPolling else { return }
        isPolling = true

        pollingTask = Task {
            while !Task.isCancelled {
                await loadTraffic(client: client)
                try? await Task.sleep(for: .seconds(2))
            }
            isPolling = false
        }
    }

    func stopPolling() {
        pollingTask?.cancel()
        pollingTask = nil
        isPolling = false
    }
}
