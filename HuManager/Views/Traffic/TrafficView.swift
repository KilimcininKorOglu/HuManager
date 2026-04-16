import SwiftUI

struct TrafficView: View {
    let client: HuaweiAPIClient
    @State private var vm = TrafficViewModel()
    @Environment(\.localization) private var lang

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let traffic = vm.traffic {
                    // Current session
                    GroupBox(lang.t(L.traffic.currentSession)) {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            GridRow {
                                Label(lang.t(L.traffic.download), systemImage: "arrow.down.circle.fill")
                                    .foregroundStyle(.green)
                                Text(TrafficFormatter.formatBytes(traffic.currentDownload))
                                    .monospacedDigit().bold()
                            }
                            GridRow {
                                Label(lang.t(L.traffic.upload), systemImage: "arrow.up.circle.fill")
                                    .foregroundStyle(.blue)
                                Text(TrafficFormatter.formatBytes(traffic.currentUpload))
                                    .monospacedDigit().bold()
                            }
                            Divider()
                            GridRow {
                                Label(lang.t(L.traffic.dlSpeed), systemImage: "speedometer")
                                    .foregroundStyle(.green)
                                Text(TrafficFormatter.formatRate(traffic.currentDownloadRate))
                                    .monospacedDigit().bold()
                            }
                            GridRow {
                                Label(lang.t(L.traffic.ulSpeed), systemImage: "speedometer")
                                    .foregroundStyle(.blue)
                                Text(TrafficFormatter.formatRate(traffic.currentUploadRate))
                                    .monospacedDigit().bold()
                            }
                            Divider()
                            GridRow {
                                Label(lang.t(L.traffic.duration), systemImage: "clock")
                                Text(TrafficFormatter.formatDuration(traffic.currentConnectTime))
                                    .monospacedDigit()
                            }
                        }
                    }

                    // Totals
                    GroupBox(lang.t(L.traffic.total)) {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            GridRow {
                                Text(lang.t(L.traffic.download))
                                Text(TrafficFormatter.formatBytes(traffic.totalDownload))
                                    .monospacedDigit()
                            }
                            GridRow {
                                Text(lang.t(L.traffic.upload))
                                Text(TrafficFormatter.formatBytes(traffic.totalUpload))
                                    .monospacedDigit()
                            }
                            GridRow {
                                Text(lang.t(L.traffic.duration))
                                Text(TrafficFormatter.formatDuration(traffic.totalConnectTime))
                                    .monospacedDigit()
                            }
                        }
                    }

                    // Monthly
                    if let month = vm.monthStats {
                        GroupBox(lang.t(L.traffic.monthly)) {
                            Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                                GridRow {
                                    Text(lang.t(L.traffic.download))
                                    Text(TrafficFormatter.formatBytes(month.monthDownload))
                                        .monospacedDigit()
                                }
                                GridRow {
                                    Text(lang.t(L.traffic.upload))
                                    Text(TrafficFormatter.formatBytes(month.monthUpload))
                                        .monospacedDigit()
                                }
                            }
                        }
                    }
                } else if !vm.isLoading {
                    Text(lang.t(L.dashboard.waitingTraffic))
                        .foregroundStyle(.secondary)
                        .padding(.top, 60)
                }
            }
            .padding()
        }
        .navigationTitle(lang.t(L.traffic.title))
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    if vm.isPolling {
                        vm.stopPolling()
                    } else {
                        vm.startPolling(client: client)
                    }
                } label: {
                    Image(systemName: vm.isPolling ? "pause.circle.fill" : "play.circle.fill")
                    Text(vm.isPolling ? lang.t(L.general.stop) : lang.t(L.general.live))
                }
            }
        }
        .task {
            await vm.loadTraffic(client: client)
        }
        .onDisappear {
            vm.stopPolling()
        }
    }
}
