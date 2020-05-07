import Foundation

extension Data {
    func mapToLines(seperator: UInt8) -> [String] {
        return withUnsafeBytes { bytes in
            return bytes
                .split(separator: seperator)
                .map { String(decoding: UnsafeRawBufferPointer(rebasing: $0), as: UTF8.self) }
        }
    }
}
