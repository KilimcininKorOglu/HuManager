import SwiftUI

struct BandLockView: View {
    let client: HuaweiAPIClient
    @State private var vm = BandLockViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Active band info
                if !vm.activeBand.isEmpty {
                    GroupBox {
                        HStack {
                            Label("Aktif Band", systemImage: "antenna.radiowaves.left.and.right")
                            Spacer()
                            Text("B\(vm.activeBand)")
                                .font(.title3.bold())
                                .foregroundStyle(.blue)
                        }
                    }
                }

                // Network mode picker
                GroupBox("Ağ Modu") {
                    Picker("Ağ Modu", selection: $vm.selectedNetworkMode) {
                        ForEach(NetworkMode.allCases) { mode in
                            Text(mode.displayName).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // LTE Band selection
                GroupBox {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("LTE Bandları")
                                .font(.headline)
                            Spacer()
                            Button("Tümü") { vm.selectAllLTE() }
                            Button("Hiçbiri") { vm.deselectAllLTE() }
                        }

                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 120), spacing: 8)
                        ], spacing: 8) {
                            ForEach(LTEBand.allCases) { band in
                                BandToggleChip(
                                    name: band.name,
                                    frequency: band.frequency,
                                    isSelected: vm.selectedLTEBands.contains(band),
                                    isActive: vm.activeBand == "\(band.rawValue)"
                                ) {
                                    if vm.selectedLTEBands.contains(band) {
                                        vm.selectedLTEBands.remove(band)
                                    } else {
                                        vm.selectedLTEBands.insert(band)
                                    }
                                }
                            }
                        }
                    }
                } label: {
                    Label("LTE", systemImage: "cellularbars")
                }

                // NR Band selection
                GroupBox {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("5G NR Bandları")
                            .font(.headline)

                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 120), spacing: 8)
                        ], spacing: 8) {
                            ForEach(NRBand.allCases) { band in
                                BandToggleChip(
                                    name: band.name,
                                    frequency: band.frequency,
                                    isSelected: vm.selectedNRBands.contains(band),
                                    isActive: false
                                ) {
                                    if vm.selectedNRBands.contains(band) {
                                        vm.selectedNRBands.remove(band)
                                    } else {
                                        vm.selectedNRBands.insert(band)
                                    }
                                }
                            }
                        }
                    }
                } label: {
                    Label("5G NR", systemImage: "antenna.radiowaves.left.and.right.circle")
                }

                // Action buttons
                HStack(spacing: 12) {
                    Button("Otomatiğe Sıfırla") {
                        Task { await vm.resetToAuto(client: client) }
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button("Uygula") {
                        Task { await vm.applyBandLock(client: client) }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(vm.selectedLTEBands.isEmpty)
                }

                if let error = vm.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            .padding()
        }
        .navigationTitle("Band Kilidi")
        .overlay {
            if vm.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
            }
        }
        .task {
            await vm.loadCurrentConfig(client: client)
        }
    }
}

// MARK: - Band Toggle Chip

struct BandToggleChip: View {
    let name: String
    let frequency: String
    let isSelected: Bool
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(name)
                    .font(.system(.body, design: .monospaced).bold())
                Text(frequency)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.accentColor.opacity(0.15) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isActive ? Color.green : (isSelected ? Color.accentColor : Color.secondary.opacity(0.3)), lineWidth: isActive ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}
