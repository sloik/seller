
import Foundation

import HTTPTypes

// MARK: - Error

public enum RequestError: Error {
    case unableToCreateRequest(path: String)
}

public protocol Request<Output> {

    /// Expected returned type.
    associatedtype Output: ContentType

    /// Path component for the request.
    var path: String { get }

    var headerFields: HTTPFields { get set }

    /// True when request should have JWT token.
    ///
    /// For reference check: [RFC6750 - The OAuth 2.0 Authorization Framework: Bearer Token Usage](https://www.rfc-editor.org/rfc/rfc6750)
    var authorizationWithJWTNeeded: Bool { get }

    var method: HTTPRequest.Method { get }
}

public extension Request {
    var method: HTTPRequest.Method {
        .get
    }

    var authorizationWithJWTNeeded: Bool {
        true
    }
}
