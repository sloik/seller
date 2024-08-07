
import SwiftUI

extension DesignSystem {

    public enum Color {

        case lightGray

        case mediumGray

        case gray111213

        case gray2426

        case gray55

        case gray5958

        case gray69

        case gray71

        case gray91

        case gray92

        case gray95
    }
}

extension DesignSystem.Color {

    /// Returns `Color` for `ColorScheme`.
    func with(_ scheme: ColorScheme) -> SwiftUI.Color {

        switch self {
        case .gray111213:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.11, green: 0.12, blue: 0.13),
                light: SwiftUI.Color(red: 0.11, green: 0.12, blue: 0.13)
            )

        case .gray2426:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.24, green: 0.24, blue: 0.26),
                light: SwiftUI.Color(red: 0.24, green: 0.24, blue: 0.26)
            )

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
            
        case .gray55:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.55, green: 0.55, blue: 0.55),
                light: SwiftUI.Color(red: 0.55, green: 0.55, blue: 0.55)
            )

        case .gray5958:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.59, green: 0.58, blue: 0.58),
                light: SwiftUI.Color(red: 0.59, green: 0.58, blue: 0.58)
            )

        case .gray71:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.71, green: 0.71, blue: 0.71),
                light: SwiftUI.Color(red: 0.71, green: 0.71, blue: 0.71)
            )

        case .gray69:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.69, green: 0.69, blue: 0.69),
                light: SwiftUI.Color(red: 0.69, green: 0.69, blue: 0.69)
            )

        case .gray92:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.92, green: 0.92, blue: 0.92),
                light: SwiftUI.Color(red: 0.92, green: 0.92, blue: 0.92)
            )

        case .gray91:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.91, green: 0.91, blue: 0.91),
                light: SwiftUI.Color(red: 0.91, green: 0.91, blue: 0.91)
            )

        case .gray95:
            return scheme.transform(
                dark: SwiftUI.Color(red: 0.95, green: 0.95, blue: 0.95),
                light: SwiftUI.Color(red: 0.95, green: 0.95, blue: 0.95)
            )
        }
    }

}
