// system
import Foundation

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/getMessageGET
struct Message: ContentType, Identifiable {
    let id: String

    enum Status: String, ContentType {
        case verifying = "VERIFYING"
        case blocked = "BLOCKED"
        case delivered = "DELIVERED"
        case interacting = "INTERACTING"
        case dismissed = "DISMISSED"
    }
    let status: Status

    enum MessageType: String, ContentType {
        case askQuestion = "ASK_QUESTION"
        case mail = "MAIL"
        case messageCenter = "MESSAGE_CENTER"
    }
    let type: MessageType
    let createdAt: String

    enum ThreadId {}
    let thread: Identifier<ThreadId>

    let author: Author
    let text: String
    let subject: String?

    struct RelatedObject: ContentType {
        let offer: Identifier<ThreadId>?
        let order: Identifier<ThreadId>?
    }
    let relatesTo: RelatedObject
    let hasAdditionalAttachments: Bool

    let attachments: [Attachment]

    struct AdditionalInformation: ContentType {
        let vin: String?
    }
    let additionalInformation: AdditionalInformation?
}
