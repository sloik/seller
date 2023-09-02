import Foundation

/// Namespace for keys that define secrets that the app can access to.
public enum Keys {

    /// Keys related to hejto developer portal.
    public enum DeveloperPortal {
        // Client id in the developer portal
        case clientId

        // App secret in the developer portal
        case clientSecret

        // Redirect uri in the developer portal
        case oauthRedirectUri

        // Authentication url that should be used in OAuth
        case authenticationString

        // Scheme used for callback from OAuth
        case callbackScheme
    }
}

/// Interface on how to get values from "Secrets".
///
/// Secret is something that the app may need byt it should
/// not be in the repository!!!.
public protocol SecretsStoreType {
    func value(for key: Keys.DeveloperPortal) -> String
}

// MARK: - Errors

/// Errors that can be thrown by `SecretsStoreType`.
public enum SecretsStoreError: Error {

    /// Thrown when the url is invalid.
    case invalidURL(String)
}


// MARK: - Nicer API

public extension SecretsStoreType {

    /// String used for creating authentication URL.
    var authenticationString: String { value(for: .authenticationString) }

    /// Scheme used by the OAuth for callback.
    var callbackScheme: String { value(for: .callbackScheme) }

    /// URL used for authentication.
    /// - `throws`: `SecretsStoreError.invalidURL` if the url is invalid.
    var authenticationURL: URL {
         get throws {
            guard
                let url: URL = authenticationString
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    .flatMap( URL.init(string:) )
             else {
                throw SecretsStoreError.invalidURL(authenticationString)
            }

            return url
        }
    }
}

// MARK: - Mock

/// Mock implementation of `SecretsStoreType`.
public final class MockSecureStore: SecretsStoreType {

    public init(){}

    /// Returns "not implemented" for all keys.
    public func value(for key: Keys.DeveloperPortal) -> String {
        "not implemented"
    }
}
