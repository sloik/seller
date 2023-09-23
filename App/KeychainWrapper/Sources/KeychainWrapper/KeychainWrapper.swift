import Security
import Foundation

//
// Maps constants from Security.framework to Swift-friendly names.
//
private let SecMatchLimit: String! = kSecMatchLimit as String
private let SecReturnData: String! = kSecReturnData as String
private let SecReturnPersistentRef: String! = kSecReturnPersistentRef as String
private let SecValueData: String! = kSecValueData as String
private let SecAttrAccessible: String! = kSecAttrAccessible as String
private let SecClass: String! = kSecClass as String
private let SecAttrService: String! = kSecAttrService as String
private let SecAttrGeneric: String! = kSecAttrGeneric as String
private let SecAttrAccount: String! = kSecAttrAccount as String
private let SecAttrAccessGroup: String! = kSecAttrAccessGroup as String
private let SecReturnAttributes: String = kSecReturnAttributes as String
private let SecAttrSynchronizable: String = kSecAttrSynchronizable as String

public final class KeychainWrapper {

    private static let defaultServiceName: String = {
        return Bundle.main.bundleIdentifier ?? "AlleSellerKeychainWrapper"
    }()

    /// ServiceName is used for the kSecAttrService property to uniquely
    /// identify this keychain accessor. If no service name is specified,
    /// KeychainWrapper will default to using the bundleIdentifier.
    private (set) public var serviceName: String

    /// AccessGroup is used for the kSecAttrAccessGroup property to identify
    /// which Keychain Access Group this entry belongs to. This allows you
    /// to use the KeychainWrapper with shared keychain access between different
    /// applications.
    private (set) public var accessGroup: String?

    public init(serviceName: String, accessGroup: String? = nil) {
        self.serviceName = serviceName
        self.accessGroup = accessGroup
    }
}

// MARK: - Setters

// MARK: - Getters
extension KeychainWrapper {

    /// Get the keys of all keychain entries matching 
    /// the current ServiceName and AccessGroup if one is set.
    var allKeys: Set<String> {

        let query: [String:Any] = [
            SecClass: kSecClassGenericPassword,
            SecAttrService: serviceName,
            SecAttrAccessGroup: accessGroup ?? "",
            SecMatchLimit: kSecMatchLimitAll,
            SecReturnAttributes: true
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard 
            status == errSecSuccess,
            let results = result as? [[String:Any]]
        else {
            return []
        }

        let keys: [String] = results
            .compactMap { (result: [String : Any]) -> String? in
                result[SecAttrAccount] as? String
            }

        return Set(keys)
    }
}

// MARK: - Query

private extension KeychainWrapper {

    /// Returns a dictionary with the query attributes used to access the keychain.
    /// It's used as starting point for other methods to more refine this query.
    func queryDictionary(
        for key: String,
        accessibility: KeychainAttrRepresentable? = nil,
        synchronizable: Bool = false
    ) -> [String:Any] {

        var query: [String:Any] = [
            SecClass: kSecClassGenericPassword,
            SecAttrService: serviceName,
        ]

        if let accessibility {
            query[SecAttrAccessible] = accessibility.keychainAttrValue
        }

        if let accessGroup {
            query[SecAttrAccessGroup] = accessGroup
        }

        if synchronizable {
            query[SecAttrSynchronizable] = kCFBooleanTrue
        }

        // Uses binary representation of the key for the `kSecAttrGeneric` and `kSecAttrAccount`
        // In theory this should make it a bit harder to find the keychain entry for a given key.
        if let encodedIdentifier = key.data(using: .utf8) {
            query[SecAttrGeneric] = encodedIdentifier
            query[SecAttrAccount] = encodedIdentifier
        }

        return query
    }
}
