
import Foundation

import Lentil

protocol LoginHandler {
    var token: String? { get }

    func logout()
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
