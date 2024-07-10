
import Foundation

public extension String {
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, tableName: "YucaLocalizable", bundle: .module, value: "", comment: "")
    }
}
