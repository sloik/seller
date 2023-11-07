// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/newMessagePOST
struct WriteNewMessageRequest: Request {
    typealias Output = Message
    typealias Input = NewMessage
    
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
    
    let token: String
}
