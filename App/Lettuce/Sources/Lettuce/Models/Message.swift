// system
import Foundation

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/getMessageGET
struct Message: ContentType {
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

    struct ThreadId: ContentType {
        let id: String
    }
    let thread: ThreadId

    struct Author: ContentType {
        let login: String
        let isInterlocutor: Bool
    }
    let author: Author
    let text: String
    let subject: String?

    struct RelatedObject: ContentType {
        let offer: ThreadId?
        let order: ThreadId?
    }
    let relatesTo: RelatedObject
    let hasAdditionalAttachments: Bool

    struct AttachmentInfo: ContentType {
        let fileName: String
        let mimeType: String?
        let url: String?

        enum Status: String, ContentType {
            case new = "NEW"
            case safe = "SAFE"
            case unsafe = "UNSAFE"
            case expired = "EXPIRED"
        }
        let status: Status
    }
    let attachments: [AttachmentInfo]

    struct AdditionalInformation: ContentType {
        let vin: String?
    }
    let additionalInformation: AdditionalInformation?
}
