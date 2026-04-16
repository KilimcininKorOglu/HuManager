import SwiftUI

struct MenuBarPanel: View {
    @Bindable var appVM: AppViewModel
    @Environment(\.localization) private var lang
    @State private var signalInfo: SignalInfo?
    @State private var monitoringStatus: MonitoringStatus?
    @State private var networkInfo: NetworkInfo?

    private let deviceService = DeviceService()

    var body: some View {
        VStack(spacing: 0) {
            headerSection
            Divider()

            if appVM.isConnected {
                connectedContent
            } else {
                disconnectedContent
            }
        }
        .frame(width: 280)
    }

    // MARK: - Header

    private var headerSection: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(appVM.isConnected ? .green : .gray)
                .frame(width: 8, height: 8)

            Text(appVM.isConnected ? appVM.modemIP : lang.t(L.general.disconnected))
                .font(.caption.bold())

            Spacer()

            if let status = monitoringStatus, appVM.isConnected {
                Text(status.networkTypeDisplay)
                    .font(.caption2.bold())
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(.blue.opacity(0.15))
                    .clipShape(Capsule())
            }
        }
        .padding(12)
    }

    // MARK: - Connected

    private var connectedContent: some View {
        VStack(spacing: 0) {
            if let signal = signalInfo {
                signalSection(signal)
                Divider()
            }

            HStack {
                Button(lang.t(L.general.refresh)) {
                    Task { await fetchData() }
                }
                .buttonStyle(.bordered)
                .controlSize(.small)

                Spacer()

                Button(lang.t(L.general.disconnect)) {
                    Task { await appVM.disconnect() }
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .tint(.red)
            }
            .padding(12)
        }
        .task { await fetchData() }
    }

    // MARK: - Signal

    private func signalSection(_ signal: SignalInfo) -> some View {
        VStack(spacing: 8) {
            signalRow("RSRP", signal.rsrp, signal.rsrpValue.map(SignalQualityHelper.rsrpQuality))
            signalRow("SINR", signal.sinr, signal.sinrValue.map(SignalQualityHelper.sinrQuality))
            signalRow("RSRQ", signal.rsrq, signal.rsrqValue.map(SignalQualityHelper.rsrqQuality))

            if signal.has5G {
                Divider()
                signalRow("NR RSRP", signal.nrRSRP, signal.nrRSRPValue.map(SignalQualityHelper.rsrpQuality))
                signalRow("NR SINR", signal.nrSINR, signal.nrSINRValue.map(SignalQualityHelper.sinrQuality))
            }

            HStack {
                Text("Band")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(signal.band)
                    .bold()
                if !signal.nrBand.isEmpty {
                    Text("/ NR \(signal.nrBand)")
                        .bold()
                }
            }
            .font(.caption)
        }
        .padding(12)
    }

    private func signalRow(_ label: String, _ value: String, _ quality: SignalQuality?) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 60, alignment: .leading)
            Text(value.isEmpty ? "-" : value)
                .font(.system(.caption, design: .monospaced))
                .monospacedDigit()
            Spacer()
            Circle()
                .fill(quality?.color ?? .gray)
                .frame(width: 8, height: 8)
        }
    }

    // MARK: - Disconnected

    private var disconnectedContent: some View {
        VStack(spacing: 12) {
            Image(systemName: "antenna.radiowaves.left.and.right.slash")
                .font(.title2)
                .foregroundStyle(.secondary)
            Text(lang.t(L.general.disconnected))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(20)
    }

    // MARK: - Data

    private func fetchData() async {
        guard let client = appVM.apiClient else { return }
        do {
            async let sig = deviceService.getSignal(client: client)
            async let mon = deviceService.getMonitoringStatus(client: client)
            async let net = deviceService.getNetworkInfo(client: client)
            signalInfo = try await sig
            monitoringStatus = try await mon
            networkInfo = try await net
        } catch {
            // Silent failure — panel shows stale or no data
        }
    }
}
