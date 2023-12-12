
import Foundation

import Lentil

protocol LoginHandlerType {
    var token: String? { get }

    func logout()

    /// Used to get new token when it expired.
    func refreshToken() async
}

extension LoginHandlerType {
    var hasToken: Bool {
        token.isNotNone
    }
}

// MARK: - Conformers

import Cumin

extension LentilUseCases: LoginHandlerType {
    var token: String? {
        userToken
    }
}
