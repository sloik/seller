// system
import Foundation

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/newMessageInThreadPOST
public struct NewMessageInThread: ContentType {
    public let text: String
    
    public struct AttachmentId: Codable, Equatable {
        public let id: String
    }
    public let attachments: [AttachmentId]?
}
