
import SwiftUI

extension DesignSystem {

    public enum Color {

        case lightGray

        case mediumGray
    }
}

extension DesignSystem.Color {

    /// Returns `Color` for `ColorScheme`.
    func with(_ scheme: ColorScheme) -> SwiftUI.Color {

        switch self {
        case .lightGray:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.46, green: 0.46, blue: 0.5).opacity(0.12),
                light: SwiftUI.Color(red: 0.46, green: 0.46, blue: 0.5).opacity(0.12)
            )

        case .mediumGray:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.69, green: 0.69, blue: 0.69),
                light: SwiftUI.Color(red: 0.69, green: 0.69, blue: 0.69)
            )
        }
    }

}
