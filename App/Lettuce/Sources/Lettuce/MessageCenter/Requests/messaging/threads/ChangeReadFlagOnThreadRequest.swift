// system
import Foundation
import HTTPTypes

// local
import Onion

typealias ReadThreadResponse = ChangeReadFlagOnThreadRequest.Response

// https://developer.allegro.pl/documentation#operation/changeReadFlagOnThreadPUT
struct ChangeReadFlagOnThreadRequest: UploadRequest {
    typealias Input = Body
    typealias Output = ReadThreadResponse

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

    internal init(
        read: Bool,
        threadId: String,
        token: String
    ) {
        self.body = .init(read: read)
        self.threadId = threadId
        self.token = token
    }
}

extension ChangeReadFlagOnThreadRequest {
    struct Response: ContentType, Identifiable {
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
