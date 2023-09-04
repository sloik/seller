// system
import Foundation

// local

// 3rd party
import AliasWonderland
import OptionalAPI

//{
//    "token_type": "Bearer",
//    "expires_in": 86400,
//    "access_token": "{access_token}"
//}
public struct Token: Codable, Equatable, Hashable {

    public enum TokenType: String, Codable {
        case bearer = "Bearer"
    }

    public let tokenType: TokenType
    public let expiresIn: Int
    public let accessToken: String

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
    }
}

extension Token {
    static var mock: Self {
        .init(tokenType: .bearer, expiresIn: 3600, accessToken: "fake-access-token")
    }
}

struct API {
    var _getTokenCode: AsyncThrowsClosure<String,Token>

    init(
        getTokenCode: @escaping AsyncThrowsClosure<String,Token>
    ) {
        self._getTokenCode = getTokenCode
    }
}

extension API {

    func getToken(code: String) async throws -> Token {
        try await _getTokenCode(code)
    }
}

extension API {
    enum E: Error {
        case notHttpResponse
        case expectedHttp200(code: Int)
    }
}



extension API {

    static var mock: Self {
        .init(
            getTokenCode: { _ in Token.mock }
        )
    }

    static var prod: Self {
        .init(
            getTokenCode: Prod.getToken(code:)
        )
    }
}

// MARK: - Prod

extension API {

    enum Prod {

        static func getToken(code: String) async throws -> Token {

            struct AuthRequestBody: Codable {

                enum GrantType: String, Codable {
                    case authorizationCode = "authorization_code"
                    case refreshToken = "refresh_token"
                }

                let clientId: String
                let clientSecret: String
                let grantType: GrantType
                let redirectUri: String
                let code: String

                private enum CodingKeys: String, CodingKey {
                    case clientId = "client_id"
                    case clientSecret = "client_secret"
                    case grantType = "grant_type"
                    case redirectUri = "redirect_uri"
                    case code
                }
            }

            let authURL = URL(string: "https://allegro.pl/auth/oauth/token")!

            var request = URLRequest(url: authURL)
            request.httpMethod = "POST"

            let body = AuthRequestBody(
                clientId: Cumin.secrets.value(for: .clientId),
                clientSecret: Cumin.secrets.value(for: .clientSecret),
                grantType: .authorizationCode,
                redirectUri: Cumin.secrets.value(for: .oauthRedirectUri),
                code: code
            )
            request.httpBody = try JSONEncoder().encode(body)

            let (data, response) = try await URLSession.shared.data(for: request)


            let httpResponse = try cast(response, to: HTTPURLResponse.self)
                .throwOrGetValue { API.E.notHttpResponse }

            guard
                200..<300 ~= httpResponse.statusCode
            else {
                throw E.expectedHttp200(code: httpResponse.statusCode)
            }

            let token = try JSONDecoder().decode(Token.self, from: data)

            return token
        }

    }
}

