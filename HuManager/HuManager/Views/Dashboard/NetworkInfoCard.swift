import SwiftUI

struct NetworkInfoCard: View {
    let network: NetworkInfo?
    let monitoring: MonitoringStatus?

    var body: some View {
        GroupBox {
            if let network {
                VStack(alignment: .leading, spacing: 8) {
                    infoRow(label: "Operatör", value: network.fullName)
                    infoRow(label: "Ağ Türü", value: monitoring?.networkTypeDisplay ?? network.networkTypeDisplay)
                    infoRow(label: "PLMN", value: network.numeric)
                    infoRow(label: "Dolaşım", value: network.roaming ? "Evet" : "Hayır")

                    if let monitoring {
                        Divider()
                        infoRow(label: "Bağlantı", value: monitoring.isConnected ? "Bağlı" : "Bağlı Değil")
                        infoRow(label: "Sinyal", value: "\(monitoring.signalIcon)/5")

                        if !monitoring.batteryPercent.isEmpty {
                            infoRow(label: "Pil", value: "%\(monitoring.batteryPercent)")
                        }
                    }
                }
            } else {
                Text("Ağ bilgisi bekleniyor...")
                    .foregroundStyle(.secondary)
            }
        } label: {
            Label("Ağ Bilgisi", systemImage: "network")
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
