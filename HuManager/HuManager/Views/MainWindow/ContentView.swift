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
        switch appVM.selectedTab {
        case .dashboard:
            Text("Gösterge Paneli — Faz 3'te gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        case .signal:
            Text("Sinyal İzleme — Faz 3'te gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        case .bands:
            Text("Band Kilidi — Faz 4'te gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        case .sms:
            Text("SMS Yönetimi — Faz 5'te gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        case .network:
            Text("Ağ Modu — Faz 4'te gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        case .traffic:
            Text("Trafik İstatistikleri — Faz 6'da gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        case .wifi:
            Text("WiFi Yönetimi — Faz 6'da gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        case .device:
            Text("Cihaz Bilgisi — Faz 6'da gelecek")
                .font(.title2)
                .foregroundStyle(.secondary)
        }
    }
}
