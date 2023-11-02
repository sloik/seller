
import Foundation

public protocol Paginated {
    var offset: UInt { get }
    var limit: UInt { get }
}

public extension Paginated {
    var paginationQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "limit", value: "\(self.limit)"),
            URLQueryItem(name: "offset", value: "\(self.offset)"),
        ]
    }
}

// MARK: - Aliases

public typealias PaginatedRequest       = Request & Paginated
public typealias PaginatedUploadRequest = UploadRequest & Paginated
