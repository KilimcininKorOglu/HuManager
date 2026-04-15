import SwiftUI

struct TrafficSummaryCard: View {
    let traffic: TrafficStatistics?

    var body: some View {
        GroupBox {
            if let traffic {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        statBlock(
                            icon: "arrow.down.circle.fill",
                            color: .green,
                            label: "İndirme",
                            value: TrafficFormatter.formatBytes(traffic.currentDownload)
                        )
                        Spacer()
                        statBlock(
                            icon: "arrow.up.circle.fill",
                            color: .blue,
                            label: "Yükleme",
                            value: TrafficFormatter.formatBytes(traffic.currentUpload)
                        )
                    }

                    Divider()

                    HStack {
                        statBlock(
                            icon: "speedometer",
                            color: .green,
                            label: "DL Hız",
                            value: TrafficFormatter.formatRate(traffic.currentDownloadRate)
                        )
                        Spacer()
                        statBlock(
                            icon: "speedometer",
                            color: .blue,
                            label: "UL Hız",
                            value: TrafficFormatter.formatRate(traffic.currentUploadRate)
                        )
                    }

                    Divider()

                    infoRow(
                        label: "Bağlantı Süresi",
                        value: TrafficFormatter.formatDuration(traffic.currentConnectTime)
                    )
                }
            } else {
                Text("Trafik verisi bekleniyor...")
                    .foregroundStyle(.secondary)
            }
        } label: {
            Label("Trafik", systemImage: "chart.bar")
        }
    }

    private func statBlock(icon: String, color: Color, label: String, value: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.caption)
            VStack(alignment: .leading) {
                Text(label)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.callout.bold())
                    .monospacedDigit()
            }
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .monospacedDigit()
        }
        .font(.callout)
    }
}
