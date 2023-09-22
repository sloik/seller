
// system
import Foundation
import OSLog

// local

// 3rd party
import AliasWonderland
import OptionalAPI
import SweetURL


public struct Token: Codable, Equatable, Hashable {

    public enum TokenType: String, Codable {
        case bearer = "bearer"
    }

    public let accessToken: String
    public let tokenType: TokenType
    public let refreshToken: String
    public let expiresIn: Int
    public let scope: String
    public let allegroApi: Bool
    public let iss: String
    public let jti: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case scope = "scope"
        case allegroApi = "allegro_api"
        case iss = "iss"
        case jti = "jti"
    }
}

extension Token {
    static var mock: Self {
        .init(accessToken: "fake-access-token", tokenType: .bearer, refreshToken: "fake-refresh-token", expiresIn: 3600, scope: "fake scope", allegroApi: true, iss: "https://allegro.pl", jti: "0ebbd602-d343-42b8-a514-f2cb9a2b8956")
    }
}
