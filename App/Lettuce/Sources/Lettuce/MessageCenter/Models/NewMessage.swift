// system
import Foundation

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/newMessagePOST
struct NewMessage: ContentType {
    struct Recipient: ContentType {
        let login: String
    }
    let recipient: Recipient
    let text: String
    
    struct MessageAttachment: ContentType {
        let id: String
    }
    let attachments: [Identifier<MessageAttachment>]?
}
