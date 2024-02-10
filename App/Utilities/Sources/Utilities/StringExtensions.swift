
import Foundation

public extension String {

    /// Variant of base64 encoding used by `JWT` tokens.
    var base64UrlDecode: Data? {
        var base64 = self.replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        // Add padding characters if needed to ensure a multiple of 4 characters
        let padding = base64.count % 4
        if padding > 0 {
            base64 += String(repeating: "=", count: 4 - padding)
        }

        return Data(base64Encoded: base64)
    }
}

// Now you can throw strings ;)
extension String: Error {}

#if canImport(SwiftUI)

import SwiftUI

extension String: View {
    public var body: Text { Text(self) }
}

#endif

// MARK: - Query Items

public extension String {

    /// Assumes that the current string is a URL path
    /// and appends the given query items to it.
    func appendToPath(items: [URLQueryItem]) -> String {
        var components = URLComponents()

        components.path = self
        components.queryItems = items

        return components.url?.absoluteString ?? self
    }
}
