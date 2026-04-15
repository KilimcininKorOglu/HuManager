import SwiftUI
import Charts

struct SignalDetailView: View {
    let client: HuaweiAPIClient
    @State private var vm = SignalViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Signal metrics table
                if let signal = vm.currentSignal {
                    GroupBox("LTE Sinyal Metrikleri") {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            metricRow("RSRP", signal.rsrp, signal.rsrpValue.map(SignalQualityHelper.rsrpQuality))
                            metricRow("RSRQ", signal.rsrq, signal.rsrqValue.map(SignalQualityHelper.rsrqQuality))
                            metricRow("SINR", signal.sinr, signal.sinrValue.map(SignalQualityHelper.sinrQuality))
                            metricRow("RSSI", signal.rssi, signal.rssiValue.map(SignalQualityHelper.rssiQuality))
                            Divider()
                            infoGridRow("Band", signal.band)
                            infoGridRow("Cell ID", signal.cellId)
                            infoGridRow("PCI", signal.pci)
                            infoGridRow("EARFCN", signal.earfcn)
                            infoGridRow("DL BW", signal.dlBandwidth)
                            infoGridRow("UL BW", signal.ulBandwidth)
                        }
                        .padding(.vertical, 4)
                    }

                    if signal.has5G {
                        GroupBox("5G NR Sinyal Metrikleri") {
                            Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                                metricRow("NR RSRP", signal.nrRSRP, signal.nrRSRPValue.map(SignalQualityHelper.rsrpQuality))
                                metricRow("NR RSRQ", signal.nrRSRQ, nil)
                                metricRow("NR SINR", signal.nrSINR, signal.nrSINRValue.map(SignalQualityHelper.sinrQuality))
                                Divider()
                                infoGridRow("NR Band", signal.nrBand)
                                infoGridRow("NR Cell ID", signal.nrCellId)
                                infoGridRow("NR PCI", signal.nrPCI)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                // RSRP Chart
                if vm.signalHistory.count > 1 {
                    GroupBox("RSRP Geçmişi") {
                        Chart(vm.signalHistory) { entry in
                            LineMark(
                                x: .value("Zaman", entry.timestamp),
                                y: .value("RSRP", entry.rsrpValue ?? -120)
                            )
                            .foregroundStyle(.blue)
                        }
                        .chartYScale(domain: -130...(-50))
                        .chartYAxisLabel("dBm")
                        .frame(height: 200)
                    }

                    GroupBox("SINR Geçmişi") {
                        Chart(vm.signalHistory) { entry in
                            LineMark(
                                x: .value("Zaman", entry.timestamp),
                                y: .value("SINR", entry.sinrValue ?? 0)
                            )
                            .foregroundStyle(.green)
                        }
                        .chartYScale(domain: -10...40)
                        .chartYAxisLabel("dB")
                        .frame(height: 200)
                    }
                }

                if vm.currentSignal == nil && !vm.isPolling {
                    Text("Sinyal verisi bekleniyor...")
                        .foregroundStyle(.secondary)
                        .padding(.top, 60)
                }
            }
            .padding()
        }
        .navigationTitle("Sinyal İzleme")
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
                    Text(vm.isPolling ? "Durdur" : "Başlat")
                }
            }

            ToolbarItem(placement: .automatic) {
                Button {
                    vm.clearHistory()
                } label: {
                    Image(systemName: "trash")
                }
                .disabled(vm.signalHistory.isEmpty)
            }
        }
        .onAppear {
            vm.startPolling(client: client)
        }
        .onDisappear {
            vm.stopPolling()
        }
    }

    @ViewBuilder
    private func metricRow(_ label: String, _ value: String, _ quality: SignalQuality?) -> some View {
        GridRow {
            Text(label)
                .foregroundStyle(.secondary)
            Text(value.isEmpty ? "-" : value)
                .monospacedDigit()
                .bold()
            Circle()
                .fill(quality?.color ?? .gray)
                .frame(width: 10, height: 10)
            Text(quality?.label ?? "")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private func infoGridRow(_ label: String, _ value: String) -> some View {
        GridRow {
            Text(label)
                .foregroundStyle(.secondary)
            Text(value.isEmpty ? "-" : value)
                .monospacedDigit()
            Color.clear
                .frame(width: 10, height: 10)
            Text("")
        }
    }
}
