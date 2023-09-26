
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
        }
    }
}
