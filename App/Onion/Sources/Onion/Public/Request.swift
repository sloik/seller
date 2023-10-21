
import Foundation
import HTTPTypes

public protocol Request<Output> {

    /// Expected returned type.
    associatedtype Output: ContentType

    /// Path component for the request.
    var path: String { get }

    var headerFields: HTTPFields { get }
}

public extension Request {
    var headerFields: HTTPFields {
        [:]
    }
}
