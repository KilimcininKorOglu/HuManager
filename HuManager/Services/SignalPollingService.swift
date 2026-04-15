import Foundation
import os

final class SignalPollingService: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "SignalPolling")
    private let deviceService = DeviceService()

    func startPolling(client: HuaweiAPIClient, interval: TimeInterval = 2.0) -> AsyncStream<SignalInfo> {
        let deviceService = self.deviceService

        let (stream, continuation) = AsyncStream<SignalInfo>.makeStream()

        let task = Task {
            while !Task.isCancelled {
                do {
                    let signal = try await deviceService.getSignal(client: client)
                    continuation.yield(signal)
                } catch {
                    if Task.isCancelled { break }
                }

                try? await Task.sleep(for: .seconds(interval))
            }
            continuation.finish()
        }

        continuation.onTermination = { _ in
            task.cancel()
        }

        return stream
    }
}
