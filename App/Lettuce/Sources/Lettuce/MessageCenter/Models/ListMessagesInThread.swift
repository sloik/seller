// system
import Foundation

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/listMessagesGET
struct MessagesInThread: ContentType, Paginated, Sendable {
    public let messages: [Message]
    public let offset: UInt
    public let limit: UInt
}
