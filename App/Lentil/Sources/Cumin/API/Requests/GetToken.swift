
import Foundation
import HTTPTypes

import Onion

struct GetToken: Request {
    typealias Output = Token

    var path: String {
        "/auth/oauth/token?grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectURI)"
    }

    var authorizationWithJWTNeeded: Bool { false }
    var headerFields: HTTPFields

    let code: String
    let encodedCredentials: String
    let redirectURI: String

    internal init(
        code: String,
        encodedCredentials: String,
        redirectURI: String
    ) {
        self.code = code
        self.encodedCredentials = encodedCredentials
        self.redirectURI = redirectURI

        self.headerFields = [
            HTTPField.Name.authorization : .basic( encodedCredentials )
        ]
    }
}
