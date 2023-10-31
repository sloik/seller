// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/newMessageInThreadPOST
public struct MessageInThread: Codable, Equatable, ContentType {
    public let text: String
    
    public struct AttachmentId: Codable, Equatable {
        public let id: String
    }
    public let attachments: [AttachmentId]?
}
