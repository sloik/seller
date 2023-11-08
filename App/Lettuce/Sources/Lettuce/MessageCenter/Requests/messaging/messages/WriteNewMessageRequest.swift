// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/newMessagePOST
struct WriteNewMessageRequest: UploadRequest {
    typealias Output = Message
    typealias Input = Body
    
    var path: String {
        "/messaging/messages"
    }
    
    var method: HTTPRequest.Method {
        .post
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .bearer(token),
            HTTPField.Name.contentType : .applicationVndAllegroV1Json
        ]
    }
    
    let body: Body
    let token: String
}

extension WriteNewMessageRequest {
    struct Body: ContentType {
        struct Recipient: ContentType {
            let login: String
        }
        let recipient: Recipient
        let text: String
        
        struct MessageAttachment: ContentType {
            let id: String
        }
        let attachments: [Identifier<MessageAttachment>]?
    }
}
