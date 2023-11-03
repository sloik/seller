// system
import Foundation
import HTTPTypes

// local
import Onion

struct GetMessage: Request {
    typealias Output = Message
    
    var path: String {
        "/messaging/messages/\(messageId)"
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .bearer(token),
            HTTPField.Name.contentType : .applicationVndAllegroV1Json
        ]
    }
    
    let token: String
    let messageId: String
}
