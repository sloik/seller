
import Foundation

public extension KeychainWrapper {
    subscript(key: String) -> Data? {
        get {
            self.data(for: key)
        }
        set {
            
            if let newValue {
                self.set(newValue, key: key)
            } else {
                self.delete(key: key)
            }
        }
    }
}
