
import Foundation

import HTTPTypes

public struct BearerToken: ContentType, ExpressibleByStringLiteral {
    public let token: String

    public init(token: String) {
        self.token = token
    }

    public init(stringLiteral value: String) {
        self.token = value
    }
}

public extension BearerToken {

    /// HTTP Header field: `Authorization: "Bearer \(token)"`.
    var httpField: HTTPField {
        HTTPField(name: .authorization, value: .bearer(token))
    }
}
