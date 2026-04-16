import SwiftUI

struct DashboardView: View {
    let client: HuaweiAPIClient
    @State private var vm = DashboardViewModel()
    @Environment(\.localization) private var lang

    var body: some View {
        ScrollView {
            if vm.isLoading && vm.deviceInfo == nil {
                ProgressView(lang.t(L.general.loading))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 100)
            } else {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ], spacing: 16) {
                    SignalSummaryCard(signal: vm.signalInfo)
                    NetworkInfoCard(
                        network: vm.networkInfo,
                        monitoring: vm.monitoringStatus
                    )
                    TrafficSummaryCard(traffic: vm.trafficStats)
                    DeviceStatusCard(
                        device: vm.deviceInfo,
                        monitoring: vm.monitoringStatus
                    )
                }
                .padding()
            }
        }
        .navigationTitle(lang.t(L.dashboard.title))
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    Task { await vm.loadAll(client: client) }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .disabled(vm.isLoading)
            }
        }
        .task {
            await vm.loadAll(client: client)
        }
    }
}
