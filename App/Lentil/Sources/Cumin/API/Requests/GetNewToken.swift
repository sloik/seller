
import Foundation
import HTTPTypes

import Onion

/// https://developer.allegro.pl/tutorials/uwierzytelnianie-i-autoryzacja-zlq9e75GdIR#przedluzenie-waznosci-tokena
struct GetNewToken: Request {
    typealias Output = Token

    ///  Example URL:  'https://allegro.pl/auth/oauth/token?grant_type=refresh_token&refresh_token=eyJ...SDA&redirect_uri=http://exemplary.redirect.uri'
    var path: String {
        "/auth/oauth/token?grant_type=refresh_token&refresh_token=\(refreshToken)&redirect_uri=\(redirectURI)"
    }

    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .basic( encodedCredentials )
        ]
    }

    let refreshToken: String
    let redirectURI: String
    let encodedCredentials: String
}
