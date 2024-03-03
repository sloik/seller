
import Foundation

public struct Identifier<Tag>: ContentType, Identifiable, ExpressibleByStringLiteral, Sendable {
    public let id: String

    public init(id: String) {
        self.id = id
    }

    public init(stringLiteral value: String) {
        self.id = value
    }
}
