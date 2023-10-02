
import Foundation

public extension KeychainWrapper {
    subscript(key: String) -> Data? {
        get {
            self.data(for: key)
        }
        set {
            if let newValue {
                self.set(newValue, key: key)
            }
            // TODO: - Implement setting none
            // https://github.com/sloik/seller/issues/22
        }
    }
}
