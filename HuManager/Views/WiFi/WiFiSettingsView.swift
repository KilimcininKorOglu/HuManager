import SwiftUI

struct WiFiSettingsView: View {
    let client: HuaweiAPIClient
    @State private var settings: WiFiSettings?
    @State private var devices: [ConnectedDevice] = []
    @State private var isLoading = false
    @Environment(\.localization) private var lang

    private let wifiService = WiFiService()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let settings {
                    GroupBox(lang.t(L.wifi.settings)) {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            infoRow(lang.t(L.wifi.ssid), settings.ssid)
                            infoRow(lang.t(L.wifi.status), settings.wifiEnable ? lang.t(L.wifi.enabled) : lang.t(L.wifi.disabled))
                            infoRow(lang.t(L.wifi.channel), settings.channel == "0" ? lang.t(L.wifi.automatic) : settings.channel)
                            infoRow(lang.t(L.wifi.security), settings.securityMode)
                            infoRow(lang.t(L.wifi.wifiPassword), settings.wpaKey.isEmpty ? settings.wepKey : settings.wpaKey)
                            if settings.maxUsers > 0 {
                                infoRow(lang.t(L.wifi.maxUsers), "\(settings.maxUsers)")
                            }
                        }
                    }
                }

                GroupBox("\(lang.t(L.wifi.connectedDevices)) (\(devices.count))") {
                    if devices.isEmpty {
                        Text(lang.t(L.wifi.noDevices))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    } else {
                        Table(devices) {
                            TableColumn(lang.t(L.wifi.deviceName)) { device in
                                Text(device.hostName.isEmpty ? "-" : device.hostName)
                            }
                            TableColumn(lang.t(L.wifi.ipAddress)) { device in
                                Text(device.ipAddress)
                                    .monospacedDigit()
                            }
                            TableColumn(lang.t(L.wifi.macAddress)) { device in
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
        .navigationTitle(lang.t(L.wifi.title))
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
