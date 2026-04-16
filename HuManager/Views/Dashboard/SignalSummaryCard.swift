import SwiftUI

struct SignalSummaryCard: View {
    @Environment(\.localization) private var lang
    let signal: SignalInfo?

    var body: some View {
        GroupBox {
            if let signal {
                VStack(alignment: .leading, spacing: 12) {
                    signalRow(label: "RSRP", value: signal.rsrp, quality: signal.rsrpValue.map(SignalQualityHelper.rsrpQuality))
                    signalRow(label: "RSRQ", value: signal.rsrq, quality: signal.rsrqValue.map(SignalQualityHelper.rsrqQuality))
                    signalRow(label: "SINR", value: signal.sinr, quality: signal.sinrValue.map(SignalQualityHelper.sinrQuality))
                    signalRow(label: "RSSI", value: signal.rssi, quality: signal.rssiValue.map(SignalQualityHelper.rssiQuality))

                    if signal.has5G {
                        Divider()
                        Text("5G NR")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                        signalRow(label: "NR RSRP", value: signal.nrRSRP, quality: signal.nrRSRPValue.map(SignalQualityHelper.rsrpQuality))
                        signalRow(label: "NR SINR", value: signal.nrSINR, quality: signal.nrSINRValue.map(SignalQualityHelper.sinrQuality))
                    }

                    HStack {
                        Text("Band:")
                            .foregroundStyle(.secondary)
                        Text(signal.band)
                            .bold()
                        if !signal.nrBand.isEmpty {
                            Text("/ NR \(signal.nrBand)")
                                .bold()
                        }
                    }
                    .font(.caption)
                }
            } else {
                Text(lang.t(L.dashboard.waitingSignal))
                    .foregroundStyle(.secondary)
            }
        } label: {
            Label(lang.t(L.dashboard.signalQuality), systemImage: "antenna.radiowaves.left.and.right")
        }
    }

    private func signalRow(label: String, value: String, quality: SignalQuality?) -> some View {
        HStack {
            Text(label)
                .frame(width: 65, alignment: .leading)
                .foregroundStyle(.secondary)
            Text(value.isEmpty ? "-" : value)
                .monospacedDigit()
            Spacer()
            Circle()
                .fill(quality?.color ?? .gray)
                .frame(width: 8, height: 8)
        }
        .font(.system(.body, design: .monospaced))
    }
}
