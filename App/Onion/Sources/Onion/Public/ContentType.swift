
import Foundation

/// Data that can be received from a server
public protocol ContentType: Codable {}

//
// Default implementations to common types that can be send thru an wire.
//
extension String: ContentType {}
