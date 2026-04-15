import Foundation

@MainActor @Observable
final class BandLockViewModel {
    var currentConfig: BandService.BandConfig?
    var selectedLTEBands: Set<LTEBand> = []
    var selectedNRBands: Set<NRBand> = []
    var selectedNetworkMode: NetworkMode = .auto
    var activeBand: String = ""
    var isLoading = false
    var errorMessage: String?

    private let bandService = BandService()
    private let deviceService = DeviceService()

    func loadCurrentConfig(client: HuaweiAPIClient) async {
        isLoading = true
        errorMessage = nil

        do {
            let config = try await bandService.getCurrentConfig(client: client)
            currentConfig = config

            selectedLTEBands = BandMaskCalculator.lteBands(from: config.lteBand)
            if let nrBand = config.nrBand {
                selectedNRBands = BandMaskCalculator.nrBands(from: nrBand)
            }
            selectedNetworkMode = NetworkMode(rawValue: config.networkMode) ?? .auto

            let signal = try await deviceService.getSignal(client: client)
            activeBand = signal.band
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func applyBandLock(client: HuaweiAPIClient) async {
        isLoading = true
        errorMessage = nil

        do {
            let lteMask = BandMaskCalculator.lteMask(from: selectedLTEBands)
            let nrMask = selectedNRBands.isEmpty ? nil : BandMaskCalculator.nrMask(from: selectedNRBands)

            try await bandService.applyBandLock(
                client: client,
                networkMode: selectedNetworkMode.rawValue,
                lteBand: lteMask,
                nrBand: nrMask
            )

            // Reload after apply
            await loadCurrentConfig(client: client)
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }

    func resetToAuto(client: HuaweiAPIClient) async {
        isLoading = true
        do {
            try await bandService.resetToAuto(client: client)
            await loadCurrentConfig(client: client)
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }

    func selectAllLTE() {
        selectedLTEBands = Set(LTEBand.allCases)
    }

    func deselectAllLTE() {
        selectedLTEBands.removeAll()
    }
}
