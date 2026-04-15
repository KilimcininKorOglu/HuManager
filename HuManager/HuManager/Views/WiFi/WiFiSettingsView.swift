import SwiftUI

struct WiFiSettingsView: View {
    let client: HuaweiAPIClient
    @State private var settings: WiFiSettings?
    @State private var devices: [ConnectedDevice] = []
    @State private var isLoading = false

    private let wifiService = WiFiService()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let settings {
                    GroupBox("WiFi Ayarları") {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            infoRow("SSID", settings.ssid)
                            infoRow("Durum", settings.wifiEnable ? "Açık" : "Kapalı")
                            infoRow("Kanal", settings.channel == "0" ? "Otomatik" : settings.channel)
                            infoRow("Güvenlik", settings.securityMode)
                            infoRow("Şifre", settings.wpaKey.isEmpty ? settings.wepKey : settings.wpaKey)
                            if settings.maxUsers > 0 {
                                infoRow("Maks Kullanıcı", "\(settings.maxUsers)")
                            }
                        }
                    }
                }

                GroupBox("Bağlı Cihazlar (\(devices.count))") {
                    if devices.isEmpty {
                        Text("Bağlı cihaz yok")
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    } else {
                        Table(devices) {
                            TableColumn("Cihaz Adı") { device in
                                Text(device.hostName.isEmpty ? "-" : device.hostName)
                            }
                            TableColumn("IP Adresi") { device in
                                Text(device.ipAddress)
                                    .monospacedDigit()
                            }
                            TableColumn("MAC Adresi") { device in
                                Text(device.macAddress)
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .frame(minHeight: CGFloat(devices.count * 32 + 40))
                    }
                }
            }
            .padding()
        }
        .navigationTitle("WiFi")
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
    }

    private func loadData() async {
        isLoading = true
        do {
            async let s = wifiService.getSettings(client: client)
            async let d = wifiService.getConnectedDevices(client: client)
            settings = try await s
            devices = try await d
        } catch {
            // Silently handle — some endpoints may not be available
        }
        isLoading = false
    }

    @ViewBuilder
    private func infoRow(_ label: String, _ value: String) -> some View {
        GridRow {
            Text(label)
                .foregroundStyle(.secondary)
            Text(value.isEmpty ? "-" : value)
        }
    }
}
