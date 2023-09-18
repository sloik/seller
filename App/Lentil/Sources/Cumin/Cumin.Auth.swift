// system
import Foundation

// local

// 3rd party
import AliasWonderland
import OptionalAPI

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
        try await _parseResultAndGetUserToken(url)
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
            .none
        }

        static func parseResultAndGetUserToken(_ url: URL) async throws {

            // Extracts code from URL
            try await URLComponents(url: url, resolvingAgainstBaseURL: false)?
                .queryItems?
                .first(where: { $0.name == "code" })?
                .value
            // Get the token from API
                .tryAsyncMap { (authCode: String) -> Token? in
                    // Make an API call to get the token
                    try await Cumin.api.getToken(code: authCode)

                }
                .whenSome { token in
                    // TODO:
                    // Store the token somewhere
                    print(token as Any)
                }
        }
    }
}

