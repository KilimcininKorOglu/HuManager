import SwiftUI

struct NetworkInfoCard: View {
    @Environment(\.localization) private var lang
    let network: NetworkInfo?
    let monitoring: MonitoringStatus?

    var body: some View {
        GroupBox {
            if let network {
                VStack(alignment: .leading, spacing: 8) {
                    infoRow(label: lang.t(L.status.operatorLabel), value: network.fullName)
                    infoRow(label: lang.t(L.status.networkType), value: monitoring?.networkTypeDisplay ?? network.networkTypeDisplay)
                    infoRow(label: lang.t(L.status.plmn), value: network.numeric)
                    infoRow(label: lang.t(L.status.roaming), value: network.roaming ? lang.t(L.general.yes) : lang.t(L.general.no))

                    if let monitoring {
                        Divider()
                        infoRow(label: lang.t(L.status.connection), value: monitoring.isConnected ? lang.t(L.status.connectionConnected) : lang.t(L.status.connectionDisconnected))
                        // Some firmware leaves SignalIcon at 0 even with a good
                        // signal; the Signal tab reads /api/device/signal instead.
                        if monitoring.signalIcon > 0 {
                            infoRow(label: lang.t(L.status.signalLabel), value: "\(monitoring.signalIcon)/5")
                        }

                        if !monitoring.batteryPercent.isEmpty {
                            infoRow(label: lang.t(L.status.battery), value: "%\(monitoring.batteryPercent)")
                        }
                    }
                }
            } else {
                Text(lang.t(L.dashboard.waitingNetwork))
                    .foregroundStyle(.secondary)
            }
        } label: {
            Label(lang.t(L.dashboard.networkInfo), systemImage: "network")
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value.isEmpty ? "-" : value)
        }
        .font(.callout)
    }
}
