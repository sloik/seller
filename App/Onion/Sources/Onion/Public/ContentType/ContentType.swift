
import Foundation

/// Data that can be received from a server
public protocol ContentType: Codable, Equatable, Hashable {}

extension ContentType {

    var data: Data {
        get throws {
            let encoder = JSONEncoder()
            return try encoder.encode(self)
        }
    }

}
