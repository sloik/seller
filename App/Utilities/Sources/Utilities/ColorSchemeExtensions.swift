
import SwiftUI

public extension ColorScheme {

    /// Transforms the color scheme into a value of the given type.
    func transform<T>(dark: T, light: T) -> T {
        switch self {
        case .dark:
            return dark

        case .light:
            return light

        @unknown default:
            fatalError()
        }
    }
}
