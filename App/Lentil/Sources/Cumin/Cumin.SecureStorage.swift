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
        var _dataForKey: Closure<Key, Data?>
        var _deleteKey: Consumer<Key>

        init(
            saveDataFor: @escaping ThrowsConsumer2I<Data,Key>,
            dataForKey: @escaping Closure<Key, Data?>,
            deleteKey: @escaping Consumer<Key>
        ) {
            self._saveDataFor = saveDataFor
            self._dataForKey = dataForKey
            self._deleteKey = deleteKey
        }
    }
}



// Nicer API
package extension CuminUseCases.SecureStore {

    func save(data: Data, for key: Key) throws {
        logger.info("Saving value for key: [\(key.rawValue)]")
        try _saveDataFor(data, key)
    }

    func data(_ key: Key) -> Data? {
        logger.info("Getting value for key: [\(key.rawValue)]")
        return _dataForKey(key)
    }

    func delete(_ key: Key) {
        logger.info("Removing value for key: [\(key.rawValue)]")
        _deleteKey(key)
    }
}

// MARK: - Factory

package extension CuminUseCases.SecureStore {

    static var prod: Self {
        .init(
            saveDataFor: CuminUseCases.SecureStore.Prod.save(data:for:), 
            dataForKey: CuminUseCases.SecureStore.Prod.data(key:),
            deleteKey: CuminUseCases.SecureStore.Prod.delete(key:)
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

        static func data(key: Key) -> Data? {
            let wrapper = KeychainWrapper()

            return wrapper[key.rawValue]
        }

        static func delete(key: Key) {
            let wrapper = KeychainWrapper()
            wrapper.delete(key: key.rawValue)
        }
    }
}

