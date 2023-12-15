
import Foundation
import HTTPTypes

import Onion

struct GetToken: Request {
    typealias Output = Token

    var path: String {
        "/auth/oauth/token?grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectURI)"
    }

    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .basic( encodedCredentials )
        ]
    }

    let code: String
    let encodedCredentials: String
    let redirectURI: String
}
