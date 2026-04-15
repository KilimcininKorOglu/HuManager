import SwiftUI

struct DeviceInfoView: View {
    let client: HuaweiAPIClient
    @State private var device: DeviceInfo?
    @State private var monitoring: MonitoringStatus?
    @State private var isLoading = false
    @State private var showRebootConfirm = false

    private let deviceService = DeviceService()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let device {
                    GroupBox("Cihaz Bilgisi") {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            infoRow("Model", device.deviceName)
                            infoRow("IMEI", device.imei)
                            infoRow("Seri No", device.serialNumber)
                            infoRow("IMSI", device.imsi)
                            infoRow("ICCID", device.iccid)
                            infoRow("MSISDN", device.msisdn)
                        }
                    }

                    GroupBox("Yazılım") {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            infoRow("Donanım", device.hardwareVersion)
                            infoRow("Yazılım", device.softwareVersion)
                            infoRow("WebUI", device.webUIVersion)
                            infoRow("MAC", device.macAddress)
                        }
                    }

                    if !device.wanIPAddress.isEmpty {
                        GroupBox("Ağ") {
                            Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                                infoRow("WAN IP", device.wanIPAddress)
                                if let monitoring {
                                    infoRow("DNS 1", monitoring.primaryDNS)
                                    infoRow("DNS 2", monitoring.secondaryDNS)
                                }
                            }
                        }
                    }
                }

                // Control buttons
                GroupBox("Cihaz Kontrolü") {
                    HStack {
                        Button(role: .destructive) {
                            showRebootConfirm = true
                        } label: {
                            Label("Yeniden Başlat", systemImage: "arrow.clockwise")
                        }
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Cihaz")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    Task { await loadData() }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .disabled(isLoading)
            }
        }
        .task {
            await loadData()
        }
        .alert("Cihazı Yeniden Başlat", isPresented: $showRebootConfirm) {
            Button("İptal", role: .cancel) {}
            Button("Yeniden Başlat", role: .destructive) {
                Task {
                    try? await deviceService.reboot(client: client)
                }
            }
        } message: {
            Text("Modem yeniden başlatılacak. Bağlantı kesilecektir.")
        }
    }

    private func loadData() async {
        isLoading = true
        do {
            async let d = deviceService.getDeviceInfo(client: client)
            async let m = deviceService.getMonitoringStatus(client: client)
            device = try await d
            monitoring = try await m
        } catch {
            // Silently handle
        }
        isLoading = false
    }

    @ViewBuilder
    private func infoRow(_ label: String, _ value: String) -> some View {
        GridRow {
            Text(label)
                .foregroundStyle(.secondary)
                .frame(width: 80, alignment: .leading)
            Text(value.isEmpty ? "-" : value)
                .textSelection(.enabled)
        }
    }
}
