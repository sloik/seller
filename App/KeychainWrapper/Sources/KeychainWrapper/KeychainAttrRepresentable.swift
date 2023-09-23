
import Foundation

public protocol KeychainAttrRepresentable {
    var keychainAttrValue: CFString { get }
}

// MARK: - Conformers

extension KeychainWrapper.ItemAccessibility: KeychainAttrRepresentable {

    var keychainAttrValue: CFString {
        self.rawValue as CFString
    }
}

