
import Foundation

extension String: ContentType {}

extension Array: ContentType where Element: ContentType {}

extension Dictionary: ContentType where Key == String, Value: ContentType {}

extension Data: ContentType {}
