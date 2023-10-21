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
        var _parseResultAndGetUserToken: AsyncThrowsConsumer<URL>

        init(
            currentToken: @escaping Producer<String?>,
            parseResultAndGetUserToken: @escaping AsyncThrowsConsumer<URL>
        ) {
            self._currentToken = currentToken
            self._parseResultAndGetUserToken = parseResultAndGetUserToken
        }
    }
}

// Nicer API
package extension CuminUseCases.Auth {

    var token: String? {
        _currentToken()
    }

    func parseResultAndGetUserToken(from url: URL) async throws {
        logger.info("Parsing result and getting user token from URL: \(url, privacy: .private)")

        do {
            try await _parseResultAndGetUserToken(url)
        } catch {
            logger.error("Failed to parse result and get user token from URL: \(url, privacy: .private) with error: \(error.localizedDescription)")
            throw error
        }
    }
}

// MARK: - Factory

package extension CuminUseCases.Auth {

    static var prod: Self {
        .init(
            currentToken: Prod.currentToken,
            parseResultAndGetUserToken: Prod.parseResultAndGetUserToken
        )
    }

    static var mock: Self {
        .prod
    }
}


// MARK: - Prod

extension CuminUseCases.Auth {

    enum Prod {

        static func currentToken() -> String? {
            try? Cumin.secureStore
                .data(.token)
                .decode( Token.self )
                .map( \.accessToken )
        }

        static func parseResultAndGetUserToken(_ url: URL) async throws {
            try await url
                .queryValues( "code" )?
                .first
                .tryAsyncMap( Cumin.api.getToken(code:) )
                .tryAsyncFlatMap { (token: Token?) in
                    try token
                        .encode()
                        .tryWhenSome { tokenData in
                            try Cumin.secureStore.save(data: tokenData, for: .token)
                        }
                }
        }
    }
}

