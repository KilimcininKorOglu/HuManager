import SwiftUI

struct NetworkInfoView: View {
    let client: HuaweiAPIClient
    @State private var network: NetworkInfo?
    @State private var monitoring: MonitoringStatus?
    @State private var isLoading = false
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

                GroupBox {
                    Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                        infoRow(lang.t(L.status.operatorLabel), network?.fullName ?? "")
                        infoRow(lang.t(L.status.plmn), network?.numeric ?? "")
                        infoRow(lang.t(L.status.networkType), networkType)
                        infoRow(lang.t(L.network.registration), network?.state ?? "")
                        infoRow(
                            lang.t(L.status.roaming),
                            (network?.roaming ?? false) ? lang.t(L.general.yes) : lang.t(L.general.no)
                        )
                    }
                } label: {
                    Label(lang.t(L.dashboard.networkInfo), systemImage: "network")
                }

                GroupBox {
                    Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 8) {
                        infoRow(
                            lang.t(L.status.connection),
                            (monitoring?.isConnected ?? false)
                                ? lang.t(L.status.connectionConnected)
                                : lang.t(L.status.connectionDisconnected)
                        )
                        // Some firmware leaves SignalIcon at 0 even with a good
                        // signal; the Signal tab reads /api/device/signal instead.
                        if let bars = monitoring?.signalIcon, bars > 0 {
                            infoRow(lang.t(L.status.signalLabel), "\(bars)/5")
                        }
                        infoRow(lang.t(L.network.serviceDomain), serviceDomain)
                        infoRow(lang.t(L.network.simStatus), monitoring?.simStatus ?? "")
                        infoRow(lang.t(L.network.primaryDns), monitoring?.primaryDNS ?? "")
                        infoRow(lang.t(L.network.secondaryDns), monitoring?.secondaryDNS ?? "")
                    }
                } label: {
                    Label(lang.t(L.status.connection), systemImage: "point.3.connected.trianglepath.dotted")
                }
            }
            .padding()
        }
        .navigationTitle(lang.t(L.sidebar.network))
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

    private var networkType: String {
        monitoring?.networkTypeDisplay ?? network?.networkTypeDisplay ?? ""
    }

    // Service domain codes reported by /api/monitoring/status.
    private var serviceDomain: String {
        switch monitoring?.currentServiceDomain {
        case 0: "No service"
        case 1: "CS only"
        case 2: "PS only"
        case 3: "CS + PS"
        default: ""
        }
    }

    private func loadData() async {
        isLoading = true
        do {
            network = try await deviceService.getNetworkInfo(client: client)
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
            Text(value.isEmpty ? "-" : value)
        }
    }
}
