import SwiftUI

struct DeviceStatusCard: View {
    @Environment(\.localization) private var lang
    let device: DeviceInfo?
    let monitoring: MonitoringStatus?

    var body: some View {
        GroupBox {
            if let device {
                VStack(alignment: .leading, spacing: 8) {
                    infoRow(label: lang.t(L.device.model), value: device.deviceName)
                    infoRow(label: "IMEI", value: device.imei)
                    infoRow(label: lang.t(L.device.serialNo), value: device.serialNumber)
                    infoRow(label: lang.t(L.device.hardware), value: device.hardwareVersion)
                    infoRow(label: lang.t(L.device.firmwareLabel), value: device.softwareVersion)

                    if !device.wanIPAddress.isEmpty {
                        Divider()
                        infoRow(label: "WAN IP", value: device.wanIPAddress)
                    }

                    if !device.macAddress.isEmpty {
                        infoRow(label: "MAC", value: device.macAddress)
                    }
                }
            } else {
                Text(lang.t(L.dashboard.waitingDevice))
                    .foregroundStyle(.secondary)
            }
        } label: {
            Label(lang.t(L.dashboard.deviceTitle), systemImage: "cpu")
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
