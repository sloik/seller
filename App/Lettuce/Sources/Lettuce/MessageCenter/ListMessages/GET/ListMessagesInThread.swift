// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/listMessagesGET
public struct MessageInThread: Codable, Equatable, ContentType, Paginated {
    public let messages: [Message]
    public let offset: Int
    public let limit: Int
}
