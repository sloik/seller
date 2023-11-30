
import SwiftUI

extension DesignSystem {

    public enum Color {

        case lightGray

        case mediumGray

        case gray55

        case gray5958

        case gray69

        case gray71

        case gray91

        case gray92
    }
}

extension DesignSystem.Color {

    func designColor(with scheme: ColorScheme) -> SwiftUI.Color {

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
        }
    }
    
}
