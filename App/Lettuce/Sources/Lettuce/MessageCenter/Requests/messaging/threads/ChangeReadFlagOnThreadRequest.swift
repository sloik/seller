// system
import Foundation
import HTTPTypes

// local
import Onion

// https://developer.allegro.pl/documentation#operation/changeReadFlagOnThreadPUT
struct ChangeReadFlagOnThreadRequest: UploadRequest {
    typealias Input = Body
    typealias Output = MessageCenterThread

    var path: String {
        "/messaging/threads/\(threadId)/read"
    }

    var headerFields: HTTPFields = [
            HTTPField.Name.contentType  : .applicationVndAllegroV1Json,
            HTTPField.Name.accept       : .applicationVndAllegroV1Json
        ]

    var method: HTTPRequest.Method { .put }

    let body: Body
    let threadId: String

    internal init(
        read: Bool,
        threadId: String
    ) {
        self.body = .init(read: read)
        self.threadId = threadId
    }
}

extension ChangeReadFlagOnThreadRequest {
    struct Body: ContentType {
        let read: Bool
    }
}
