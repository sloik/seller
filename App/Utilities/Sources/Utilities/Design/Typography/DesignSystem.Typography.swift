
import SwiftUI

extension DesignSystem {

    /// Typography.
    public enum Typography {

        /// Smaller than regilar abel.
        case smallerLabel(weight: Font.Weight = .regular)

        /// Smaller than regilar abel.
        case mediumLabel(weight: Font.Weight = .regular)

        /// Smaller than label.
        case body(weight: Font.Weight = .regular)

        /// Normal text and buttons.
        case label(weight: Font.Weight = .regular)

        /// Big title
        case bigTitle(weight: Font.Weight = .heavy)

        @available(*, deprecated, message: "👨‍🎨 Design System: Please use any other value!")
        case custom(weight: Font.Weight = .regular, size: CGFloat = 17)
    }
}

extension DesignSystem.Typography {

    var designFont: Font {
        switch self {
        case .smallerLabel(let weight):
            font(weight: weight, size: 11)

        case .mediumLabel(weight: let weight):
            font(weight: weight, size: 12)

        case .body(let weight):
            font(weight: weight, size: 13)

        case .label(let weight):
            font(weight: weight, size: 17)

        case .bigTitle(let weight):
            font(weight: weight, size: 24)
            
        case .custom(let weight, let size):
            font(weight: weight, size: size)
        }
    }

}

private func font(weight: Font.Weight, size: CGFloat) -> Font {

#if canImport(AppKit)
    let newSize = size
#else
    let newSize = UIFontMetrics.default.scaledValue(for: size)
#endif

    return Font.system(
        size: newSize,
        weight: weight
    )
}
