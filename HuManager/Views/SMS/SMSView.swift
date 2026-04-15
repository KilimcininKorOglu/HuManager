import SwiftUI

struct SMSView: View {
    let client: HuaweiAPIClient
    @State private var vm = SMSViewModel()

    var body: some View {
        HSplitView {
            // Message list
            VStack(spacing: 0) {
                if let count = vm.smsCount {
                    HStack {
                        Text("Gelen Kutusu")
                            .font(.headline)
                        Spacer()
                        if count.totalUnread > 0 {
                            Text("\(count.totalUnread) okunmamış")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(.red.opacity(0.15))
                                .clipShape(Capsule())
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    Divider()
                }

                if vm.isLoading && vm.messages.isEmpty {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if vm.messages.isEmpty {
                    Spacer()
                    Text("Mesaj yok")
                        .foregroundStyle(.secondary)
                    Spacer()
                } else {
                    List(vm.messages, selection: $vm.selectedMessage) { message in
                        SMSListRow(message: message)
                            .tag(message)
                            .contextMenu {
                                Button("Sil", role: .destructive) {
                                    Task { await vm.deleteSMS(client: client, message: message) }
                                }
                            }
                    }
                    .listStyle(.inset)
                }
            }
            .frame(minWidth: 300)

            // Detail / Compose
            VStack {
                if vm.showCompose {
                    SMSComposeView(
                        phone: $vm.composePhone,
                        content: $vm.composeContent,
                        isSending: vm.isSending,
                        onSend: { Task { await vm.sendSMS(client: client) } },
                        onCancel: { vm.showCompose = false }
                    )
                } else if let message = vm.selectedMessage {
                    SMSDetailView(message: message)
                } else {
                    Text("Bir mesaj seçin")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(minWidth: 300)
        }
        .navigationTitle("SMS")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    vm.showCompose.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }

            ToolbarItem(placement: .automatic) {
                Button {
                    Task { await vm.loadInbox(client: client) }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .disabled(vm.isLoading)
            }
        }
        .task {
            await vm.loadInbox(client: client)
        }
    }
}

// MARK: - SMS List Row

struct SMSListRow: View {
    let message: SMSMessage

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if !message.isRead {
                    Circle()
                        .fill(.blue)
                        .frame(width: 8, height: 8)
                }
                Text(message.phone)
                    .font(.headline)
                    .lineLimit(1)
                Spacer()
                Text(message.date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(message.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - SMS Detail View

struct SMSDetailView: View {
    let message: SMSMessage

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(message.phone)
                            .font(.title2.bold())
                        Text(message.date)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }

                Divider()

                Text(message.content)
                    .textSelection(.enabled)
            }
            .padding()
        }
    }
}

// MARK: - SMS Compose View

struct SMSComposeView: View {
    @Binding var phone: String
    @Binding var content: String
    let isSending: Bool
    let onSend: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Yeni SMS")
                    .font(.title3.bold())
                Spacer()
                Button("İptal") { onCancel() }
            }

            TextField("Telefon Numarası", text: $phone)
                .textFieldStyle(.roundedBorder)

            TextEditor(text: $content)
                .font(.body)
                .frame(minHeight: 100)
                .border(Color.secondary.opacity(0.3))

            HStack {
                Text("\(content.count) karakter")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Button(action: onSend) {
                    HStack {
                        if isSending {
                            ProgressView()
                                .controlSize(.small)
                        }
                        Text("Gönder")
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(phone.isEmpty || content.isEmpty || isSending)
            }
        }
        .padding()
    }
}
