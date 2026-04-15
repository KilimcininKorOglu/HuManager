import SwiftUI

struct ContentView: View {
    @Bindable var appVM: AppViewModel

    var body: some View {
        Group {
            if appVM.isConnected {
                NavigationSplitView {
                    SidebarView(selectedTab: $appVM.selectedTab)
                } detail: {
                    detailView
                }
            } else {
                LoginView(appVM: appVM)
            }
        }
        .alert("Hata", isPresented: $appVM.showError) {
            Button("Tamam", role: .cancel) {}
        } message: {
            Text(appVM.errorMessage ?? "Bilinmeyen hata")
        }
    }

    @ViewBuilder
    private var detailView: some View {
        if let client = appVM.apiClient {
            switch appVM.selectedTab {
            case .dashboard:
                DashboardView(client: client)
            case .signal:
                SignalDetailView(client: client)
            case .bands:
                BandLockView(client: client)
            case .sms:
                SMSView(client: client)
            case .network:
                BandLockView(client: client)
            case .traffic:
                TrafficView(client: client)
            case .wifi:
                WiFiSettingsView(client: client)
            case .device:
                DeviceInfoView(client: client)
            }
        }
    }
}
