import Foundation

@MainActor @Observable
final class SignalViewModel {
    var currentSignal: SignalInfo?
    var signalHistory: [SignalInfo] = []
    var isPolling = false
    var errorMessage: String?

    private let pollingService = SignalPollingService()
    private var pollingTask: Task<Void, Never>?

    private let maxHistoryCount = 300

    func startPolling(client: HuaweiAPIClient) {
        guard !isPolling else { return }
        isPolling = true

        pollingTask = Task {
            let stream = pollingService.startPolling(client: client)
            for await signal in stream {
                currentSignal = signal
                signalHistory.append(signal)
                if signalHistory.count > maxHistoryCount {
                    signalHistory.removeFirst(signalHistory.count - maxHistoryCount)
                }
            }
            isPolling = false
        }
    }

    func stopPolling() {
        pollingTask?.cancel()
        pollingTask = nil
        isPolling = false
    }

    func clearHistory() {
        signalHistory.removeAll()
    }
}
