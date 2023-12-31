
import Foundation
import HTTPTypes

public protocol Request<Output> {

    /// Expected returned type.
    associatedtype Output: ContentType

    /// Path component for the request.
    var path: String { get }

    var headerFields: HTTPFields { get }

    var method: HTTPRequest.Method { get }
}

public extension Request {
    var headerFields: HTTPFields {
        [:]
    }

    var method: HTTPRequest.Method {
        .get
    }

    /// True when request should have JWT token.
    ///
    /// For reference check: [RFC6750 - The OAuth 2.0 Authorization Framework: Bearer Token Usage](https://www.rfc-editor.org/rfc/rfc6750)
    var authorizationWithJWTNeeded: Bool {
        headerFields[values: .authorization]
            .map{ $0.lowercased() }
            .contains { value in value.contains("bearer") }
    }
}
