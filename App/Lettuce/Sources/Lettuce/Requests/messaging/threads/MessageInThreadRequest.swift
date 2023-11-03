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
            HTTPField.Name.authorization : .bearer(token),
            HTTPField.Name.contentType : .applicationVndAllegroV1Json
        ]
    }

    var method: HTTPRequest.Method {
        .post
    }

    let token: String
    let threadId: String

    struct Body: ContentType {
        let text: String
        let attachments: [Identifier<Attachment>]?

        enum Recipient {}
        let recipient: Identifier<Recipient>
    }
    let body: Body
}
