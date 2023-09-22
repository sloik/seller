// system
import Foundation
import OSLog

// local

// 3rd party
import AliasWonderland
import OptionalAPI
import SweetURL

private let logger = Logger(subsystem: "API", category: "API")

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
        logger.info("Getting token from code: \(code, privacy: .private)")

        do {
            return try await _getTokenCode(code)
        } catch {
            logger.error("Failed to get token from code: \(code, privacy: .private) with error: \(error.localizedDescription)")
            throw error
        }
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

