import Foundation

import OSLog

private let logger = Logger(subsystem: "SecretsStore", category: "SecretsStore")

/// Namespace for keys that define secrets that the app can access to.
public enum Keys {

    /// Keys related to Allegro App Setting developer portal.
    public enum DeveloperPortal {
        /// Client id in the developer portal
        case clientId

        // App secret in the developer portal
        case clientSecret

        /// Redirect uri in the developer portal
        case oauthRedirectUri

        /// Authentication url that should be used in OAuth
        case authenticationString

        /// Scheme used for callback from OAuth
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

    /// Thrown when `client id` and `client secret` cannot be encoded.
    case unableToEncodeClientCredentials

    /// Thrown when the redirect uri cannot be created.
    case unableToCreateRedirectUri
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
                logger.error("Unable to create authentication url")
                throw SecretsStoreError.invalidURL(authenticationString)
            }

            return url
        }
    }

    /// Base64 encoded `client id` and `client secret`.
    /// - `throws`: `SecretsStoreError.unableToEncodeClientCredentials` when credentials cannot be encoded.
    var encodedCredentials: String {
        get throws {

            let credentials = "\(value(for: .clientId)):\(value(for: .clientSecret))"

            guard
                let encodedCredentials = credentials.data(using: .utf8)?.base64EncodedString()
            else {
                logger.error("Unable to encode credentials")
                throw SecretsStoreError.unableToEncodeClientCredentials
            }

            return encodedCredentials
        }
    }

    /// Redirect uri that is used for OAuth.
    /// - `throws`: `SecretsStoreError.unableToCreateRedirectUri` when unable to create the redirect uri.
    var oauthRedirectUri: String {
        get throws {
            guard
                let uri = value(for: .oauthRedirectUri).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                logger.error("Unable to encode redirect uri")
                throw SecretsStoreError.unableToCreateRedirectUri
            }

            return uri
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
