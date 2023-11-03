
import Foundation

public struct Identifier: ContentType, Identifiable {
    let id: String

    public init(id: String) {
        self.id = id
    }
}
