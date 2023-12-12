
import Foundation

import Lentil

protocol LoginHandler {
    var token: String? { get }

    func logout()

    /// Used to get new token when it expired.
    func refreshToken() async
}

extension LoginHandler {
    var hasToken: Bool {
        token.isNotNone
    }
}

// MARK: - Conformers

import Cumin

extension LentilUseCases: LoginHandler {
    var token: String? {
        userToken
    }
}
