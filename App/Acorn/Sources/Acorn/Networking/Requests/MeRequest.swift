
// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/meGET
struct MeRequest: Request {
    typealias Output = User

    var path: String {
        "/me"
    }

    var headerFields: HTTPFields = [
        HTTPField.Name.accept: .applicationVndAllegroV1Json,
    ]
}
