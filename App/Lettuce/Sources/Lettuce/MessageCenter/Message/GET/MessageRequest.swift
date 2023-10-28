// system
import Foundation
import HTTPTypes

// local
import Onion

struct GetMessage: Request {
    typealias Output = Message
    
    var path: String {
        "https://api.allegro.pl/messaging/messages/\(messageId)"
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
