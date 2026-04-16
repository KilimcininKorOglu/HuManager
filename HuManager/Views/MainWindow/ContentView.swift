import SwiftUI

struct ContentView: View {
    @Bindable var appVM: AppViewModel
    @Environment(\.localization) private var lang

    var body: some View {
        Group {
            if appVM.isConnected {
                NavigationSplitView {
                    SidebarView(selectedTab: $appVM.selectedTab)
                } detail: {
                    detailView
                }
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        StatusBarView(
                            connectionState: appVM.connectionState,
                            webUIVersion: appVM.webUIVersion,
                            modemIP: appVM.modemIP,
                            onDisconnect: {
                                Task { await appVM.disconnect() }
                            }
                        )
                    }
                    ToolbarItem(placement: .automatic) {
                        LanguagePicker()
                    }
                }
            } else {
                LoginView(appVM: appVM)
            }
        }
        .alert(lang.t(L.general.error), isPresented: $appVM.showError) {
            Button(lang.t(L.general.ok), role: .cancel) {}
        } message: {
            Text(appVM.errorMessage ?? lang.t(L.general.unknownError))
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
