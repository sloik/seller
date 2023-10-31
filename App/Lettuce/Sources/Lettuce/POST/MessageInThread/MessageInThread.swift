// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/newMessageInThreadPOST
public struct MessageInThread: Codable, Equatable, ContentType {
    public let text: String
    
    public struct MessageAttachmentId: Codable, Equatable {
        public let id: String
    }
    public let attachments: [MessageAttachmentId]?
}
