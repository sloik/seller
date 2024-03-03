// system
import Foundation

// local
import Onion

import OptionalAPI
import Zippy

/// https://developer.allegro.pl/documentation#operation/getMessageGET
struct Message: ContentType, Identifiable, Sendable {
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
        case platformMessage = "PLATFORM_MESSAGE"
    }
    let type: MessageType
    let createdAt: String

    enum ThreadId {}
    let thread: Identifier<ThreadId>

    let author: Author
    let text: String
    let subject: String?
    let offer: Offer?
    struct RelatedObject: ContentType {
        let offer: Offer?
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

extension Message: Comparable {

    // Try to compare dates first and then later string as fallback
    static func < (lhs: Message, rhs: Message) -> Bool {
        zip( lhs.createdAt.isoDate, rhs.createdAt.isoDate )
            .map( < )
            .or( lhs.createdAt < rhs.createdAt )
    }
}
