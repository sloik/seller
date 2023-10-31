// system
import Foundation
import HTTPTypes

// local
import Onion

struct DeleteMessage: Request {
    typealias Output = Message
    
    var path: String {
        "/messaging/messages/\(messageId)"
    }
    
    var method: HTTPRequest.Method {
        .delete
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : "Bearer \(token)",
            HTTPField.Name.contentType : "application/vnd.allegro.public.v1+json"
        ]
    }
    
    let token: String
    let messageId: String
}
