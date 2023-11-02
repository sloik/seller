
import Foundation

/// Data that can be received from a server
public protocol ContentType: Codable, Equatable {}

// MARK: - Common ContentType types

extension String: ContentType {}

extension Array: ContentType where Element: ContentType {}

extension Dictionary: ContentType where Key == String, Value: ContentType {}
