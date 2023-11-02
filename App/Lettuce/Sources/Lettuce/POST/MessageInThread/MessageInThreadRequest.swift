// system
import Foundation
import HTTPTypes

// local
import Onion

struct PostMessageInThread: UploadRequest {
    typealias Output = Message
    
    var path: String {
        "/messaging/threads/\(threadId)/messages"
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : "Bearer \(token)",
            HTTPField.Name.contentType : "application/vnd.allegro.public.v1+json"
        ]
    }

    var method: HTTPRequest.Method {
        .post
    }

    let token: String
    let threadId: String

    struct Body: ContentType {
        let text: String

        struct AttachmentId: ContentType {
            let id: String
        }
        let attachments: [AttachmentId]?

        struct Recipient: ContentType {
            let id: String
        }
        let recipient: Recipient
    }
    let body: Body
}
