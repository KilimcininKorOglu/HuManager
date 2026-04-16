import Foundation
import os

final class BandService: Sendable {

    private let logger = Logger(subsystem: "com.humanager", category: "BandService")

    struct BandConfig: Sendable {
        let networkMode: String
        let networkBand: String
        let lteBand: String
        let nrBand: String?
    }

    func getCurrentConfig(client: HuaweiAPIClient) async throws -> BandConfig {
        let response = try await client.get(Endpoints.netMode)

        return BandConfig(
            networkMode: response["NetworkMode"] as? String ?? "00",
            networkBand: response["NetworkBand"] as? String ?? "3FFFFFFF",
            lteBand: response["LTEBand"] as? String ?? "7FFFFFFFFFFFFFFF",
            nrBand: response["NRBand"] as? String
        )
    }

    func applyBandLock(
        client: HuaweiAPIClient,
        networkMode: String,
        networkBand: String = "3FFFFFFF",
        lteBand: String,
        nrBand: String? = nil
    ) async throws {
        var elements: [(String, String)] = [
            ("NetworkMode", networkMode),
            ("NetworkBand", networkBand),
            ("LTEBand", lteBand)
        ]

        if let nrBand {
            elements.append(("NRBand", nrBand))
        }

        let body = XMLRequestBuilder.buildOrdered(elements: elements)
        _ = try await client.post(Endpoints.netMode, body: body)
        logger.info("Band lock applied: LTE=\(lteBand), mode=\(networkMode)")
    }

    func resetToAuto(client: HuaweiAPIClient) async throws {
        try await applyBandLock(
            client: client,
            networkMode: "00",
            lteBand: "7FFFFFFFFFFFFFFF"
        )
        logger.info("Band lock reset (auto)")
    }
}
