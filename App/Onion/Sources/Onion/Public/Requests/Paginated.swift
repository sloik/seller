
import Foundation

public protocol Paginated {
    var offset: Int { get }
    var limit: Int { get }
}

public extension Paginated {
    static var defaultLimit: Int { 20 }
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
