
// system
import Foundation
import HTTPTypes

// local
import Onion

struct MeRequest: Request {
    typealias Output = User

    var path: String {
        "/me"
    }

    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .bearer(token),
            HTTPField.Name.contentType : .applicationVndAllegroV1Json
        ]
    }

    let token: String
}
