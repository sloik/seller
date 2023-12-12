
import HTTPTypes

@testable import Onion
import Foundation

struct JustRequest: Request {
    typealias Output = String
    var path: String = "/"
}

struct AuthorizationRequest: Request {
    typealias Output = String
    var path: String = "/"

    var headerFields: HTTPFields { [HTTPField.Name.authorization : .bearer("token")] }
}
