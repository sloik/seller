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
    
    var headerFields: HTTPFields = [
        HTTPField.Name.accept : .applicationVndAllegroV1Json,
        HTTPField.Name.contentType: .applicationVndAllegroV1Json,
    ]

    var method: HTTPRequest.Method {
        .post
    }

    let threadId: String

    struct Body: ContentType {
        let text: String
        let attachments: [Identifier<Attachment>]?
    }
    let body: Body
}
