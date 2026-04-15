import Foundation
import os

actor HeartbeatService {

    private let logger = Logger(subsystem: "com.humanager", category: "Heartbeat")
    private var heartbeatTask: Task<Void, Never>?
    private(set) var isRunning = false
    var interval: TimeInterval = 30.0

    func start(client: HuaweiAPIClient) {
        stop()
        isRunning = true

        heartbeatTask = Task { [weak self] in
            while !Task.isCancelled {
                let sleepInterval = await self?.interval ?? 30.0
                try? await Task.sleep(for: .seconds(sleepInterval))

                if Task.isCancelled { break }

                do {
                    _ = try await client.get(Endpoints.stateLogin)
                } catch {
                    await self?.logger.warning("Heartbeat hatası: \(error.localizedDescription)")
                }
            }

            await self?.setRunningState(false)
        }

        logger.info("Heartbeat başlatıldı (\(self.interval)sn aralık)")
    }

    func stop() {
        heartbeatTask?.cancel()
        heartbeatTask = nil
        isRunning = false
        logger.info("Heartbeat durduruldu")
    }

    private func setRunningState(_ value: Bool) {
        isRunning = value
    }
}
