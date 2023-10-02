// system
import Foundation
import OSLog

// local
import KeychainWrapper

// 3rd party
import AliasWonderland
import OptionalAPI

private let logger = Logger(subsystem: "CuminUseCases", category: "SecureStore")

package extension CuminUseCases {

    /// Abstraction for storing securely data (e.g. tokens) in the keychain.
    struct SecureStore {

        package enum Key: String {
            case token, refreshToken
        }

        var _saveDataFor: ThrowsConsumer2I<Data,Key>

        init(
            saveDataFor: @escaping Consumer2I<Data,Key>
        ) {
            self._saveDataFor = saveDataFor
        }
    }
}



// Nicer API
package extension CuminUseCases.SecureStore {

    func save(data: Data, for key: Key) throws {
        logger.info("Saving value for key: [\(key.rawValue)]")
        try _saveDataFor(data, key)
    }


}

// MARK: - Factory

package extension CuminUseCases.SecureStore {

    static var prod: Self {
        .init(
            saveDataFor: CuminUseCases.SecureStore.Prod.save(data:for:)
        )
    }

    static var mock: Self {
        .prod
    }
}


// MARK: - Prod

extension CuminUseCases.SecureStore {

    enum Prod {
        static func save(data: Data, for key: Key) {
            let wrapper = KeychainWrapper()

            wrapper["key"] = data
        }
    }
}

