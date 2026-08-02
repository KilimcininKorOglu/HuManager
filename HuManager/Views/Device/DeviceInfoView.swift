import SwiftUI

struct DeviceInfoView: View {
    let client: HuaweiAPIClient
    @State private var device: DeviceInfo?
    @State private var monitoring: MonitoringStatus?
    @State private var isLoading = false
    @State private var showRebootConfirm = false
    @State private var errorMessage: String?
    @Environment(\.localization) private var lang

    private let deviceService = DeviceService()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let errorMessage {
                    ErrorBanner(message: errorMessage) {
                        self.errorMessage = nil
                    }
                }

                if let device {
                    GroupBox(lang.t(L.device.deviceInfo)) {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            infoRow(lang.t(L.device.model), device.deviceName)
                            infoRow("IMEI", device.imei)
                            infoRow(lang.t(L.device.serialNo), device.serialNumber)
                            infoRow("IMSI", device.imsi)
                            infoRow("ICCID", device.iccid)
                            infoRow("MSISDN", device.msisdn)
                        }
                    }

                    GroupBox(lang.t(L.device.software)) {
                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                            infoRow(lang.t(L.device.hardware), device.hardwareVersion)
                            infoRow(lang.t(L.device.firmwareLabel), device.softwareVersion)
                            infoRow("WebUI", device.webUIVersion)
                            infoRow("MAC", device.macAddress)
                        }
                    }

                    if !device.wanIPAddress.isEmpty {
                        GroupBox(lang.t(L.device.networkSection)) {
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
                GroupBox(lang.t(L.device.control)) {
                    HStack {
                        Button(role: .destructive) {
                            showRebootConfirm = true
                        } label: {
                            Label(lang.t(L.device.reboot), systemImage: "arrow.clockwise")
                        }
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .navigationTitle(lang.t(L.device.title))
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
        .alert(lang.t(L.device.rebootConfirmTitle), isPresented: $showRebootConfirm) {
            Button(lang.t(L.general.cancel), role: .cancel) {}
            Button(lang.t(L.device.reboot), role: .destructive) {
                Task { await reboot() }
            }
        } message: {
            Text(lang.t(L.device.rebootConfirmMessage))
        }
    }

    private func reboot() async {
        do {
            try await deviceService.reboot(client: client)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func loadData() async {
        isLoading = true
        do {
            device = try await deviceService.getDeviceInfo(client: client)
            monitoring = try await deviceService.getMonitoringStatus(client: client)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
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
