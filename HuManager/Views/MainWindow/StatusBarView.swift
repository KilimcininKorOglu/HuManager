import SwiftUI

struct StatusBarView: View {
    let connectionState: ConnectionState
    let webUIVersion: WebUIVersion?
    let modemIP: String
    let onDisconnect: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)

            Text(statusText)
                .font(.caption)
                .foregroundStyle(.secondary)

            if let version = webUIVersion {
                Text("v\(version.rawValue)")
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(.secondary.opacity(0.15))
                    .clipShape(Capsule())
            }

            if case .connected = connectionState {
                Button("Bağlantıyı Kes") {
                    onDisconnect()
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
            }
        }
    }

    private var statusColor: Color {
        switch connectionState {
        case .connected: .green
        case .connecting: .yellow
        case .disconnected: .gray
        case .error: .red
        }
    }

    private var statusText: String {
        switch connectionState {
        case .connected: modemIP
        case .connecting: "Bağlanıyor..."
        case .disconnected: "Bağlı Değil"
        case .error: "Hata"
        }
    }
}
