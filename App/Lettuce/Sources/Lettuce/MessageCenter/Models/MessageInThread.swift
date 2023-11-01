// system
import Foundation

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/newMessageInThreadPOST
struct NewMessageInThread: ContentType {
    let text: String
    let attachments: [Identifier<Attachment>]?
}
