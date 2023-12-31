
import SwiftUI

public extension ColorScheme {

    /// Returns `true` if the color scheme is dark.
    var isDark: Bool { self == .dark }

    /// Returns `true` if the color scheme is light.
    var isLight: Bool { self == .light }

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
