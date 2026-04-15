import Foundation
import CryptoKit
import CommonCrypto

enum CryptoHelpers {

    // MARK: - SHA256

    static func sha256(_ string: String) -> Data {
        let data = Data(string.utf8)
        let hash = SHA256.hash(data: data)
        return Data(hash)
    }

    static func sha256Hex(_ string: String) -> String {
        sha256(string).hexString
    }

    static func sha256Base64Hex(_ string: String) -> String {
        let hexDigest = sha256Hex(string)
        return Data(hexDigest.utf8).base64URLEncodedString()
    }

    // MARK: - HMAC-SHA256

    static func hmacSHA256(key: Data, data: Data) -> Data {
        let symmetricKey = SymmetricKey(data: key)
        let signature = HMAC<SHA256>.authenticationCode(for: data, using: symmetricKey)
        return Data(signature)
    }

    static func hmacSHA256(key: Data, message: String) -> Data {
        hmacSHA256(key: key, data: Data(message.utf8))
    }

    // MARK: - PBKDF2

    static func pbkdf2SHA256(
        password: String,
        salt: Data,
        iterations: Int,
        keyLength: Int = 32
    ) -> Data {
        var derivedKey = Data(count: keyLength)

        let result = derivedKey.withUnsafeMutableBytes { derivedKeyBytes in
            salt.withUnsafeBytes { saltBytes in
                CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    password,
                    password.utf8.count,
                    saltBytes.baseAddress?.assumingMemoryBound(to: UInt8.self),
                    salt.count,
                    CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                    UInt32(iterations),
                    derivedKeyBytes.baseAddress?.assumingMemoryBound(to: UInt8.self),
                    keyLength
                )
            }
        }

        guard result == kCCSuccess else {
            fatalError("PBKDF2 türetme hatası: \(result)")
        }

        return derivedKey
    }

    // MARK: - XOR

    static func xorBytes(_ a: Data, _ b: Data) -> Data {
        precondition(a.count == b.count, "XOR: veri boyutları eşit olmalı")
        var result = Data(count: a.count)
        for i in 0..<a.count {
            result[i] = a[i] ^ b[i]
        }
        return result
    }

    // MARK: - Nonce Generation

    static func generateNonce(byteCount: Int = 32) -> String {
        var bytes = [UInt8](repeating: 0, count: byteCount)
        _ = SecRandomCopyBytes(kSecRandomDefault, byteCount, &bytes)
        return bytes.map { String(format: "%02x", $0) }.joined()
    }
}

// MARK: - Data Extensions

extension Data {

    var hexString: String {
        map { String(format: "%02x", $0) }.joined()
    }

    init?(hexString: String) {
        let hex = hexString
        let len = hex.count / 2
        var data = Data(capacity: len)
        var index = hex.startIndex

        for _ in 0..<len {
            let nextIndex = hex.index(index, offsetBy: 2)
            guard let byte = UInt8(hex[index..<nextIndex], radix: 16) else { return nil }
            data.append(byte)
            index = nextIndex
        }

        self = data
    }

    func base64URLEncodedString() -> String {
        base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }
}
