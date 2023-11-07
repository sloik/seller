// system
import Foundation
import OSLog
import HTTPTypes

// local
import Onion

// 3rd party
import AliasWonderland
import OptionalAPI
import SweetURL

private let logger = Logger(subsystem: "API", category: "API")

final class API {
    var _getTokenCode: AsyncThrowsClosure2I<String, APIClientType, Token>
    var _authClient: APIClientType

    init(
        getTokenCode: @escaping AsyncThrowsClosure2I<String, APIClientType, Token>,
        authClient:  APIClientType
    ) {
        self._getTokenCode = getTokenCode
        self._authClient = authClient
    }
}

extension API {

    var currentClient: APIClientType {
        _authClient
    }

    func getToken(code: String) async throws -> Token {
        logger.info("Getting token from code: \(code, privacy: .private)")

        do {
            return try await _getTokenCode(code, currentClient)
        } catch {
            logger.error("Failed to get token from code: \(code, privacy: .private) with error: \(error.localizedDescription)")
            throw error
        }
    }
}

extension API {
    enum E: Error {
        case notHttpResponse
        case unableToCreateRequest
    }
}

extension API {

    static var mock: Self {
        .init(
            getTokenCode: { _,_ in Token.mock },
            authClient: Mock.ApiClient()
        )
    }

    static func prod(apiClient: APIClientType) -> Self {
        .init(
            getTokenCode: Prod.getToken(code:authClient:),
            authClient: apiClient
        )
    }
}

// MARK: - Prod

extension API {

    enum Prod {

        static func getToken(code: String, authClient: APIClientType) async throws -> Token {

            guard
                let encodedCredentials: String = "\(Cumin.secrets.value(for: .clientId)):\(Cumin.secrets.value(for: .clientSecret))"
                    .data(using: .utf8)?
                    .base64EncodedString(),
                let redirectURI: String = Cumin.secrets.value(for: .oauthRedirectUri).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                logger.error("Unable to create request with credentials and redirect URI")
                throw E.unableToCreateRequest
            }

            let tokenRequest = GetToken(
                code: code,
                encodedCredentials: encodedCredentials,
                redirectURI: redirectURI
            )

            let (token, httpResponse): (Token, HTTPResponse) = try await authClient.run( tokenRequest )

            logger.info("Response: \(httpResponse.debugDescription)")

            return token
        }

    }

    enum Mock {

        final class ApiClient: APIClientType {

            let baseURL: URL = URL(string: "https://fake.api.pl")!

            func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
                fatalError()
            }

            func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPTypes.HTTPResponse) {
                fatalError()
            }
        }
    }
}

