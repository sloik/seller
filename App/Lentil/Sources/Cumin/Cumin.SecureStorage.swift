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

        package enum E: Error {
            case unableToSaveData(key: Key)
        }

        var _saveDataFor: ThrowsConsumer2I<Data,Key>
        var _dataForKey: ThrowsClosure<Key, Data?>

        init(
            saveDataFor: @escaping ThrowsConsumer2I<Data,Key>,
            dataForKey: @escaping ThrowsClosure<Key, Data?>
        ) {
            self._saveDataFor = saveDataFor
            self._dataForKey = dataForKey
        }
    }
}



// Nicer API
package extension CuminUseCases.SecureStore {

    func save(data: Data, for key: Key) throws {
        logger.info("Saving value for key: [\(key.rawValue)]")
        try _saveDataFor(data, key)
    }

    func data(_ key: Key) throws -> Data? {
        logger.info("Getting value for key: [\(key.rawValue)]")
        return try _dataForKey(key)
    }
}

// MARK: - Factory

package extension CuminUseCases.SecureStore {

    static var prod: Self {
        .init(
            saveDataFor: CuminUseCases.SecureStore.Prod.save(data:for:), 
            dataForKey: CuminUseCases.SecureStore.Prod.data(key:)
        )
    }

    static var mock: Self {
        .prod
    }
}


// MARK: - Prod

extension CuminUseCases.SecureStore {

    enum Prod {
        static func save(data: Data, for key: Key) throws {
            let wrapper = KeychainWrapper()
            guard
                wrapper.set(data, key: key.rawValue)
            else {
                throw E.unableToSaveData(key: key)
            }
        }

        static func data(key: Key) throws -> Data? {
            let wrapper = KeychainWrapper()

            return wrapper[key.rawValue]
        }
    }
}

