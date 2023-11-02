
import Foundation

public protocol Paginated {
    var offset: UInt { get }
    var limit: UInt { get }
}

public extension Paginated {
    var offset: UInt {
        0
    }

    var limit: UInt {
        20
    }

    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
    }
}

// MARK: - Aliases

public typealias PaginatedRequest       = Request & Paginated
public typealias PaginatedUploadRequest = UploadRequest & Paginated
