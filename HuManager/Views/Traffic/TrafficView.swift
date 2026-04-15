import SwiftUI

struct TrafficView: View {
    let client: HuaweiAPIClient
    @State private var vm = TrafficViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let traffic = vm.traffic {
                    // Current session
                    GroupBox("Mevcut Oturum") {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            GridRow {
                                Label("İndirme", systemImage: "arrow.down.circle.fill")
                                    .foregroundStyle(.green)
                                Text(TrafficFormatter.formatBytes(traffic.currentDownload))
                                    .monospacedDigit().bold()
                            }
                            GridRow {
                                Label("Yükleme", systemImage: "arrow.up.circle.fill")
                                    .foregroundStyle(.blue)
                                Text(TrafficFormatter.formatBytes(traffic.currentUpload))
                                    .monospacedDigit().bold()
                            }
                            Divider()
                            GridRow {
                                Label("DL Hız", systemImage: "speedometer")
                                    .foregroundStyle(.green)
                                Text(TrafficFormatter.formatRate(traffic.currentDownloadRate))
                                    .monospacedDigit().bold()
                            }
                            GridRow {
                                Label("UL Hız", systemImage: "speedometer")
                                    .foregroundStyle(.blue)
                                Text(TrafficFormatter.formatRate(traffic.currentUploadRate))
                                    .monospacedDigit().bold()
                            }
                            Divider()
                            GridRow {
                                Label("Süre", systemImage: "clock")
                                Text(TrafficFormatter.formatDuration(traffic.currentConnectTime))
                                    .monospacedDigit()
                            }
                        }
                    }

                    // Totals
                    GroupBox("Toplam") {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            GridRow {
                                Text("İndirme")
                                Text(TrafficFormatter.formatBytes(traffic.totalDownload))
                                    .monospacedDigit()
                            }
                            GridRow {
                                Text("Yükleme")
                                Text(TrafficFormatter.formatBytes(traffic.totalUpload))
                                    .monospacedDigit()
                            }
                            GridRow {
                                Text("Süre")
                                Text(TrafficFormatter.formatDuration(traffic.totalConnectTime))
                                    .monospacedDigit()
                            }
                        }
                    }

                    // Monthly
                    if let month = vm.monthStats {
                        GroupBox("Aylık") {
                            Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                                GridRow {
                                    Text("İndirme")
                                    Text(TrafficFormatter.formatBytes(month.monthDownload))
                                        .monospacedDigit()
                                }
                                GridRow {
                                    Text("Yükleme")
                                    Text(TrafficFormatter.formatBytes(month.monthUpload))
                                        .monospacedDigit()
                                }
                            }
                        }
                    }
                } else if !vm.isLoading {
                    Text("Trafik verisi bekleniyor...")
                        .foregroundStyle(.secondary)
                        .padding(.top, 60)
                }
            }
            .padding()
        }
        .navigationTitle("Trafik İstatistikleri")
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
                    Text(vm.isPolling ? "Durdur" : "Canlı")
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
