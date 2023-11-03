// system
import Foundation
import HTTPTypes

// local
import Onion

// https://developer.allegro.pl/documentation#operation/changeReadFlagOnThreadPUT
struct ChangeReadFlagOnThreadRequest: UploadRequest {
    typealias Input = Body
    typealias Output = Response
    
    var path: String {
        "/messaging/threads/\(threadId)/read"
    }

    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .bearer(token),
            HTTPField.Name.contentType : .applicationVndAllegroV1Json
        ]
    }

    var method: HTTPRequest.Method { .put }

    let body: Body
    let threadId: String
    let token: String
}

extension ChangeReadFlagOnThreadRequest {
    struct Response: ContentType {
        let id: String
        let read: Bool
        let lastMessageDateTime: String
        let interlocutor: Interlocutor
    }
}

extension ChangeReadFlagOnThreadRequest {
    struct Body: ContentType {
        let read: Bool
    }
}
