// system
import Foundation

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/listMessagesGET
struct MessageInThread: ContentType, Paginated {
    public let messages: [Message]
    public let offset: UInt
    public let limit: UInt
}
