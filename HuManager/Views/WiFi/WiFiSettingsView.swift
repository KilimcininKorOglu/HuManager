import SwiftUI

struct WiFiSettingsView: View {
    let client: HuaweiAPIClient
    @State private var settings: WiFiSettings?
    @State private var devices: [ConnectedDevice] = []
    @State private var isLoading = false
    @State private var isEditing = false
    @State private var errorMessage: String?
    @State private var statusMessage: String?
    @Environment(\.localization) private var lang

    // Draft state, only meaningful while isEditing.
    @State private var draftSSID = ""
    @State private var draftPassword = ""
    @State private var draftAuthMode: WiFiAuthMode = .wpaWpa2PSK
    @State private var draftHidden = false

    private let wifiService = WiFiService()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let errorMessage {
                    ErrorBanner(message: errorMessage) {
                        self.errorMessage = nil
                    }
                }

                if let statusMessage {
                    Text(statusMessage)
                        .font(.callout)
                        .foregroundStyle(.green)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }

                if let settings {
                    GroupBox(lang.t(L.wifi.settings)) {
                        if isEditing {
                            editor
                        } else {
                            summary(settings)
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
                .disabled(isLoading || isEditing)
            }
        }
        .task {
            await loadData()
        }
    }

    @ViewBuilder
    private func summary(_ settings: WiFiSettings) -> some View {
        VStack(alignment: .leading, spacing: 12) {
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

            Button(lang.t(L.wifi.edit)) {
                beginEditing(settings)
            }
        }
    }

    @ViewBuilder
    private var editor: some View {
        VStack(alignment: .leading, spacing: 12) {
            Form {
                TextField(lang.t(L.wifi.ssid), text: $draftSSID)

                Picker(lang.t(L.wifi.security), selection: $draftAuthMode) {
                    ForEach(WiFiAuthMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }

                if draftAuthMode.requiresPassword {
                    SecureField(lang.t(L.wifi.wifiPassword), text: $draftPassword)
                }

                Toggle(lang.t(L.wifi.hideSsid), isOn: $draftHidden)
            }
            .formStyle(.grouped)

            Text(lang.t(L.wifi.restartWarning))
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack {
                Button(lang.t(L.general.cancel)) {
                    isEditing = false
                }

                Button(lang.t(L.wifi.save)) {
                    Task { await save() }
                }
                .keyboardShortcut(.defaultAction)
                .disabled(isLoading || draftSSID.isEmpty)
            }
        }
    }

    private func beginEditing(_ settings: WiFiSettings) {
        draftSSID = settings.ssid
        draftPassword = settings.wpaKey
        draftAuthMode = WiFiAuthMode(rawValue: settings.securityMode) ?? .wpaWpa2PSK
        draftHidden = false
        statusMessage = nil
        isEditing = true
    }

    private func save() async {
        isLoading = true
        do {
            // The SSID write restarts the radio, so apply security first.
            if draftAuthMode.requiresPassword {
                try await wifiService.setSecurity(
                    client: client,
                    authMode: draftAuthMode,
                    password: draftPassword,
                    restart: false
                )
            }

            try await wifiService.setSSID(
                client: client,
                ssid: draftSSID,
                hidden: draftHidden,
                restart: true
            )

            isEditing = false
            errorMessage = nil
            statusMessage = lang.t(L.wifi.saved)
            await loadData()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    private func loadData() async {
        isLoading = true
        do {
            settings = try await wifiService.getSettings(client: client)
            devices = try await wifiService.getConnectedDevices(client: client)
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
            Text(value.isEmpty ? "-" : value)
        }
    }
}
