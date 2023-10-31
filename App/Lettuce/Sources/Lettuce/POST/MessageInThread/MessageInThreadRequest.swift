// system
import Foundation
import HTTPTypes

// local
import Onion

struct PostMessageInThread: Request {
    typealias Output = Message
    
    var path: String {
        "/messaging/threads/\(threadId)/messages"
    }
    
    var method: HTTPRequest.Method {
        .post
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : "Bearer \(token)",
            HTTPField.Name.contentType : "application/vnd.allegro.public.v1+json"
        ]
    }
    
    let token: String
    let threadId: String
}
