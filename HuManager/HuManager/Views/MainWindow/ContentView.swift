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
                placeholderView("Band Kilidi", "Faz 4")
            case .sms:
                placeholderView("SMS Yönetimi", "Faz 5")
            case .network:
                placeholderView("Ağ Modu", "Faz 4")
            case .traffic:
                placeholderView("Trafik İstatistikleri", "Faz 6")
            case .wifi:
                placeholderView("WiFi Yönetimi", "Faz 6")
            case .device:
                placeholderView("Cihaz Bilgisi", "Faz 6")
            }
        }
    }

    private func placeholderView(_ title: String, _ phase: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.title2)
            Text("\(phase)'te gelecek")
                .foregroundStyle(.secondary)
        }
    }
}
