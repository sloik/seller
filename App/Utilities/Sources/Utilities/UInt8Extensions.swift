
import Foundation

public extension UInt8 {

    /// Returns the binary representation of the `UInt8` as a `String`.
    var asBinary: String {
        String(self, radix: 2)
            .padding(toLength: 8, withPad: "0", startingAt: 0)
    }

    /// Returns the hexadecimal representation of the `UInt8` as a `String`.
    var asHex: String {
        "0x"
        +
        String(
            String(self, radix: 16)
                .padding(toLength: 2, withPad: "0", startingAt: 0)
                .reversed()
        )
        .uppercased()
    }
}
