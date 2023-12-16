
// System
import Foundation

// Local
import Lentil
import Onion

// MARK: - Conformers

import Cumin

extension LentilUseCases: LoginHandlerType {
    public var token: String? {
        userToken
    }
}
