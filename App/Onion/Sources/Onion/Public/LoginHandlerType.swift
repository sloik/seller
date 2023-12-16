
// System
import Foundation

// Local

// 3rd party
import OptionalAPI

public protocol LoginHandlerType {
    var token: String? { get }

    func logout()

    /// Used to get new token when it expired.
    func refreshToken() async throws
}

public extension LoginHandlerType {
    var hasToken: Bool {
        token.isNotNone
    }
}
