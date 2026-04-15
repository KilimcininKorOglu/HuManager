import SwiftUI

struct LoginView: View {
    @Bindable var appVM: AppViewModel
    @State private var isConnecting = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            VStack(spacing: 8) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: 48))
                    .foregroundStyle(.blue)
                Text("HuManager")
                    .font(.largeTitle.bold())
                Text("Huawei Modem Yönetimi")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 16) {
                TextField("Modem IP Adresi", text: $appVM.modemIP)
                    .textFieldStyle(.roundedBorder)

                TextField("Kullanıcı Adı", text: $appVM.username)
                    .textFieldStyle(.roundedBorder)

                SecureField("Şifre", text: $appVM.password)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { connectAction() }
            }
            .frame(maxWidth: 300)

            Button(action: connectAction) {
                HStack(spacing: 8) {
                    if isConnecting {
                        ProgressView()
                            .controlSize(.small)
                    }
                    Text(isConnecting ? "Bağlanıyor..." : "Bağlan")
                }
                .frame(maxWidth: 300)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(isConnecting || appVM.modemIP.isEmpty)

            if case .error(let msg) = appVM.connectionState {
                Text(msg)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .frame(maxWidth: 300)
            }

            Spacer()
        }
        .padding(40)
        .frame(minWidth: 500, minHeight: 400)
    }

    private func connectAction() {
        isConnecting = true
        Task {
            await appVM.connect()
            isConnecting = false
        }
    }
}
