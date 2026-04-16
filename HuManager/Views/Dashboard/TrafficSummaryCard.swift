import SwiftUI

struct TrafficSummaryCard: View {
    @Environment(\.localization) private var lang
    let traffic: TrafficStatistics?

    var body: some View {
        GroupBox {
            if let traffic {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        statBlock(
                            icon: "arrow.down.circle.fill",
                            color: .green,
                            label: lang.t(L.traffic.download),
                            value: TrafficFormatter.formatBytes(traffic.currentDownload)
                        )
                        Spacer()
                        statBlock(
                            icon: "arrow.up.circle.fill",
                            color: .blue,
                            label: lang.t(L.traffic.upload),
                            value: TrafficFormatter.formatBytes(traffic.currentUpload)
                        )
                    }

                    Divider()

                    HStack {
                        statBlock(
                            icon: "speedometer",
                            color: .green,
                            label: lang.t(L.traffic.dlSpeed),
                            value: TrafficFormatter.formatRate(traffic.currentDownloadRate)
                        )
                        Spacer()
                        statBlock(
                            icon: "speedometer",
                            color: .blue,
                            label: lang.t(L.traffic.ulSpeed),
                            value: TrafficFormatter.formatRate(traffic.currentUploadRate)
                        )
                    }

                    Divider()

                    infoRow(
                        label: lang.t(L.traffic.connectTime),
                        value: TrafficFormatter.formatDuration(traffic.currentConnectTime)
                    )
                }
            } else {
                Text(lang.t(L.dashboard.waitingTraffic))
                    .foregroundStyle(.secondary)
            }
        } label: {
            Label(lang.t(L.dashboard.trafficTitle), systemImage: "chart.bar")
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
