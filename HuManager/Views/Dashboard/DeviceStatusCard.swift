import SwiftUI

struct DeviceStatusCard: View {
    let device: DeviceInfo?
    let monitoring: MonitoringStatus?

    var body: some View {
        GroupBox {
            if let device {
                VStack(alignment: .leading, spacing: 8) {
                    infoRow(label: "Model", value: device.deviceName)
                    infoRow(label: "IMEI", value: device.imei)
                    infoRow(label: "Seri No", value: device.serialNumber)
                    infoRow(label: "Donanım", value: device.hardwareVersion)
                    infoRow(label: "Yazılım", value: device.softwareVersion)

                    if !device.wanIPAddress.isEmpty {
                        Divider()
                        infoRow(label: "WAN IP", value: device.wanIPAddress)
                    }

                    if !device.macAddress.isEmpty {
                        infoRow(label: "MAC", value: device.macAddress)
                    }
                }
            } else {
                Text("Cihaz bilgisi bekleniyor...")
                    .foregroundStyle(.secondary)
            }
        } label: {
            Label("Cihaz", systemImage: "cpu")
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value.isEmpty ? "-" : value)
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .font(.callout)
    }
}
