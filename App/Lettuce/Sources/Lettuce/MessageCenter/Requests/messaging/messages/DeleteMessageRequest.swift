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
    
    var headerFields: HTTPFields = [
        HTTPField.Name.contentType : .applicationVndAllegroV1Json
    ]
    
    let messageId: String
}
