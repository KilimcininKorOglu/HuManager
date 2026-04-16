import SwiftUI

struct LoginView: View {
    @Bindable var appVM: AppViewModel
    @Environment(\.localization) private var lang
    @State private var isConnecting = false

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Spacer()
                LanguagePicker()
            }
            .padding(.top, 8)

            Spacer()

            VStack(spacing: 8) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: 48))
                    .foregroundStyle(.blue)
                Text(lang.t(L.general.appName))
                    .font(.largeTitle.bold())
                Text(lang.t(L.general.appSubtitle))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 16) {
                TextField(lang.t(L.login.modemIP), text: $appVM.modemIP)
                    .textFieldStyle(.roundedBorder)

                TextField(lang.t(L.login.username), text: $appVM.username)
                    .textFieldStyle(.roundedBorder)

                SecureField(lang.t(L.login.password), text: $appVM.password)
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
                    Text(isConnecting ? lang.t(L.general.connecting) : lang.t(L.general.connect))
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
