// system
import Foundation
import OSLog

// local

// 3rd party
import AliasWonderland
import OptionalAPI

private let logger = Logger(subsystem: "CuminUseCases", category: "Auth")

package extension CuminUseCases {

    struct Auth {
        var _currentToken: Producer<String?>
        var _currentRefreshToken: Producer<String?>
        var _fetchNewTokenUsingRefreshToken: AsyncThrowsConsumer<Void>

        var _parseResultAndGetUserToken: AsyncThrowsConsumer<URL, SideEffectClosure>

        init(
            currentToken: @escaping Producer<String?>,
            currentRefreshToken: @escaping Producer<String?>,
            fetchNewTokenUsingRefreshToken: @escaping  AsyncThrowsConsumer<Void>,
            parseResultAndGetUserToken: @escaping AsyncThrowsConsumer<URL, SideEffectClosure>
        ) {
            self._currentToken = currentToken
            self._currentRefreshToken = currentRefreshToken
            self._fetchNewTokenUsingRefreshToken = fetchNewTokenUsingRefreshToken

            self._parseResultAndGetUserToken = parseResultAndGetUserToken
        }
    }
}

// Nicer API
package extension CuminUseCases.Auth {

    var token: String? {
        _currentToken()
    }

    var refreshToken: String? {
        _currentRefreshToken()
    }

    func parseResultAndGetUserToken(from url: URL, didLogin: @escaping SideEffectClosure) async throws {
        logger.info("Parsing result and getting user token from URL: \(url, privacy: .private)")

        do {
            try await _parseResultAndGetUserToken(url, didLogin)
        } catch {
            logger.error("Failed to parse result and get user token from URL: \(url, privacy: .private) with error: \(error.localizedDescription)")
            throw error
        }
    }

    func fetchNewTokenUsingRefreshToken() async throws {
        try await _fetchNewTokenUsingRefreshToken( () )
    }
}

// MARK: - Factory

package extension CuminUseCases.Auth {

    static var prod: Self {
        .init(
            currentToken: Prod.currentToken,
            currentRefreshToken: Prod.currentRefreshToken, 
            fetchNewTokenUsingRefreshToken: Prod.fetchNewTokenUsingRefreshToken,
            parseResultAndGetUserToken: Prod.parseResultAndGetUserToken
        )
    }

    static var mock: Self {
        .prod
    }
}

// MARK: - Errors

package extension CuminUseCases.Auth {
    
    enum E: Error {
        case noRefreshToken
    }
}


// MARK: - Prod

extension CuminUseCases.Auth {

    enum Prod {

        static func currentToken() -> String? {
            Cumin.secureStore
                .data(.token)
                .decode( Token.self )
                .map( \.accessToken )
        }

        static func currentRefreshToken() -> String? {
            logger.debug("\(type(of: self)) \(#function)>")

            return Cumin.secureStore
                .data(.token)
                .decode( Token.self )
                .map( \.refreshToken )
        }

        static func fetchNewTokenUsingRefreshToken() async throws {
            guard 
                let refreshToken = currentRefreshToken()
            else {
                logger.error("\(type(of: self)) \(#function)> Failed to fetch new token using refresh token because refresh token was nil")
                throw E.noRefreshToken
            }

            // Box in optional to get
            let newToken: Token?

            do {
                newToken = try await Cumin.api.getNewToken(refreshToken: refreshToken)
            } catch {
                logger.error("\(type(of: self)) \(#function)> Failed to fetch new token using refresh token because of error: \(error.localizedDescription)")

                // TODO: inspect errors and throw more concrete errors

                throw error
            }

            try newToken
                .encode()
                .tryWhenSome { tokenData in
                    try Cumin.secureStore.save(data: tokenData, for: .token)
                }

        }

        static func parseResultAndGetUserToken(_ url: URL, didLogin: @escaping SideEffectClosure) async throws {
            try await url
                .queryValues( "code" )?
                .first
                .tryAsyncMap( Cumin.api.getToken(code:) )
                .tryAsyncFlatMap { (token: Token?) in
                    try token
                        .encode()
                        .tryWhenSome { tokenData in
                            try Cumin.secureStore.save(data: tokenData, for: .token)
                            didLogin()
                        }
                }
        }
    }
}

