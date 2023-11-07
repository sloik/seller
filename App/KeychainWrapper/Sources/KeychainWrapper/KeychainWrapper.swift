
// System
import Security
import Foundation
import OSLog

// Local

// 3rd Party
import OptionalAPI

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
private let SecUseDataProtectionKeychain: String = kSecUseDataProtectionKeychain as String

private let logger = Logger(subsystem: "KeychainWrapper", category: "KeychainWrapper")

public final class KeychainWrapper {

    public static let defaultServiceName: String = {
        return Bundle.main.bundleIdentifier ?? "AlleSellerKeychainWrapperServiceName"
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

    public init(
        serviceName: String = KeychainWrapper.defaultServiceName,
        accessGroup: String? = nil
    ) {
        self.serviceName = serviceName
        self.accessGroup = accessGroup
    }
}

// MARK: - Setters
public extension KeychainWrapper {

    @discardableResult
    func set(
        _ value: Data,
        key: String,
        accessibility: KeychainAttrRepresentable? = nil,
        synchronizable: Bool = false
    ) -> Bool {
        var query = queryDictionary(for: key, accessibility: accessibility, synchronizable: synchronizable)

        // passes value to query
        query[SecValueData] = value

//        // Item must have accessibility set so default is used when none is specified.
//        query[SecAttrAccessible] = accessibility
//                                    .or( KeychainWrapper.ItemAccessibility.whenUnlocked )
//                                    .keychainAttrValue

        // Add item to keychain.
        let status = SecItemAdd(query as CFDictionary, nil)

        // Item might be a new entry or a duplicate.
        // If it's a new entry then just return `true` signalling that the item was added.
        // If the value already exists in the keychain update existing value.
        // Otherwise return `false`.
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return update(value, key: key, accessibility: accessibility, synchronizable: synchronizable)
        } else {
            let errorMessage = errorMessage(statusCode: status)
            logger.debug("Status code: <\(status)> message: <\(errorMessage)> for key: <\(key)>")
            return false
        }
    }

    private func update(
        _ value: Data,
        key: String,
        accessibility: KeychainAttrRepresentable? = nil,
        synchronizable: Bool = false
    ) -> Bool {
        let query = queryDictionary(for: key, accessibility: accessibility, synchronizable: synchronizable)

        let updateDictionary = [SecValueData: value]

        // Update existing item in the keychain.
        let status = SecItemUpdate(query as CFDictionary, updateDictionary as CFDictionary)

        return status == errSecSuccess
    }
}

// MARK: - Getters
public extension KeychainWrapper {
    
    /// Get the keys and values of all keychain entries matching
    /// the current ServiceName and AccessGroup if one is set.
    var allEntries: [String:String] {
        
        let query: [String:Any] = [
            SecClass: kSecClassGenericPassword,
            SecAttrService: serviceName,
            SecMatchLimit: kSecMatchLimitAll,
            SecReturnAttributes: true,
            SecReturnRefference as String : kCFBooleanTrue ?? true,
        ]
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        guard
            status == errSecSuccess,
            let results = result as? [[String:Any]]
        else {
            return [:]
        }
        
        
        return results
            .compactMap { (result: [String:Any]) -> [String:String] in
                if let keyData:Data = result[kSecAttrAccount as String] as? Data,
                   let key:String = String(data: keyData, encoding:.utf8),
                   let valueData:Data = result[kSecValueData as String] as? Data,
                   let value: String = String(data: valueData, encoding:.utf8) {
                    return [key:value]
                }
                return [:]
        }
            .flatMap{$0}
            .reduce([String:String]()) {
                (dict, entries) in
                var dictionary = dict
                dictionary.updateValue(entries.value, forKey: entries.key)
                return dictionary
            }
    }

    func data(
        for key: String,
        accessibility: KeychainAttrRepresentable? = nil,
        synchronizable: Bool = false
    ) -> Data? {
        var query = queryDictionary(for: key, accessibility: accessibility, synchronizable: synchronizable)

        // We want the data
        query[SecReturnData] = kCFBooleanTrue

        // Only one item
        query[SecMatchLimit] = kSecMatchLimitOne

        // Run query
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        return status == errSecSuccess ? result as? Data : nil
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

        let query: [String:Any] = [
            SecClass: kSecClassGenericPassword,
            SecAttrAccount:  key.data(using: .utf8)!,
            SecAttrService: serviceName,
        ]

        return query
    }

    /// Returns a string explaining the meaning of a security result code.
    func errorMessage(statusCode: OSStatus) -> String {
        SecCopyErrorMessageString(statusCode, nil)
            .cast( String.self )
            .or( "Unknown Error" )
    }
}
