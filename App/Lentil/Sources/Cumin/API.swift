// system
import Foundation

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

final class API {
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
        case unableToCreateRequest
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

            let authURL = URL(string: "https://allegro.pl/auth/oauth/token")!

            var components = URLComponents(url: authURL, resolvingAgainstBaseURL: true)

            guard
                let redirectURI = Cumin.secrets.value(for: .oauthRedirectUri).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                throw E.unableToCreateRequest
            }

            components?.queryItems = [
                .init(name: "grant_type", value: "authorization_code"),
                .init(name: "code", value: code),
                .init(
                    name: "redirect_uri",
                    value: redirectURI
                ),
            ]

            guard
                let tokenURL = components?.url,
                let encodedCredentials = "\(Cumin.secrets.value(for: .clientId)):\(Cumin.secrets.value(for: .clientSecret))" .data(using: .utf8)?
                    .base64EncodedString()
            else {
                throw E.unableToCreateRequest
            }

            let request = tokenURL
                .asRequest(method: .get)
                .set(
                    header: .authorization,
                    value: "Basic \(encodedCredentials)"
                )

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

