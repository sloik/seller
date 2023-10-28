// system
import Foundation
import HTTPTypes

// local
import Onion

public enum MessageStatus: String, Codable {
    case verifying = "VERIFYING"
    case blocked = "BLOCKED"
    case delivered = "DELIVERED"
    case interacting = "INTERACTING"
    case dismissed = "DISMISSED"
}

public enum MessageType: String, Codable {
    case askQuestion = "ASK_QUESTION"
    case mail = "MAIL"
    case messageCenter = "MESSAGE_CENTER"
}

public enum MessageAttachmentStatus: String, Codable {
    case new = "NEW"
    case safe = "SAFE"
    case unsafe = "UNSAFE"
    case expired = "EXPIRED"
}

/// https://developer.allegro.pl/documentation#operation/getMessageGET
public struct Message: Codable, Equatable, ContentType {
    public let id: String
    public let status: MessageStatus.RawValue
    public let type: MessageType.RawValue
    public let createdAt: String
    
    public struct ThreadId: Codable, Equatable {
        public let id: String
    }
    public let thread: ThreadId
    
    public struct MessageAuthor: Codable, Equatable {
        public let login: String
        public let isInterlocutor: Bool
    }
    public let author: MessageAuthor
    public let text: String
    public let subject: String?
    
    public struct MessageRelatedObject: Codable, Equatable {
        public let offer: ThreadId?
        public let order: ThreadId?
    }
    public let relatesTo: MessageRelatedObject
    public let hasAdditionalAttachments: Bool
    
    public struct MessageAttachmentInfo: Codable, Equatable {
        public let fileName: String
        public let mimeType: String?
        public let url: String?
        public let status: MessageAttachmentStatus.RawValue
    }
    public let attachments: [MessageAttachmentInfo]
    
    public struct MessageAdditionalInformation: Codable, Equatable {
        public let vin: String?
    }
    public let additionalInformation: MessageAdditionalInformation?
}