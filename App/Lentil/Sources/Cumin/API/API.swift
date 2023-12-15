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
    var _getTokenCode: AsyncThrowsClosure<String, APIClientType, Token>
    var _getNewToken: AsyncThrowsClosure<String, APIClientType, Token>

    var _authClient: APIClientType

    init(
        getTokenCode: @escaping AsyncThrowsClosure<String, APIClientType, Token>,
        getNewToken: @escaping AsyncThrowsClosure<String, APIClientType, Token>,
        authClient:  APIClientType
    ) {
        self._getTokenCode = getTokenCode
        self._getNewToken = getNewToken

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

    func getNewToken(refreshToken: String) async throws -> Token {
        logger.info("Getting new token from refresh token: \(refreshToken, privacy: .private)")

        do {
            return try await _getNewToken(refreshToken, currentClient)
        } catch {
            logger.error("Failed to get new token from refresh token: \(refreshToken, privacy: .private) with error: \(error.localizedDescription)")
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
            getNewToken: { _,_ in Token.mock },
            authClient: Mock.ApiClient()
        )
    }

    static func prod(apiClient: APIClientType) -> Self {
        .init(
            getTokenCode: Prod.getToken(code:authClient:),
            getNewToken: Prod.getNewToken(refreshToken:authClient:),
            authClient: apiClient
        )
    }
}

// MARK: - Prod

extension API {

    enum Prod {

        static func getToken(code: String, authClient: APIClientType) async throws -> Token {

            let tokenRequest = GetToken(
                code: code,
                encodedCredentials: try Cumin.secrets.encodedCredentials,
                redirectURI: try Cumin.secrets.oauthRedirectUri
            )

            let (token, httpResponse): (Token, HTTPResponse) = try await authClient.run( tokenRequest )

            logger.info("Response: \(httpResponse.debugDescription)")

            return token
        }

        static func getNewToken(refreshToken: String, authClient: APIClientType) async throws -> Token {

            let refreshToken = GetNewToken(
                refreshToken: refreshToken,
                redirectURI: try Cumin.secrets.oauthRedirectUri,
                encodedCredentials: try Cumin.secrets.encodedCredentials
            )

            let (token, httpResponse): (Token, HTTPResponse) = try await authClient.run( refreshToken )

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

