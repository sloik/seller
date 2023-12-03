
import SwiftUI

extension DesignSystem {

    /// Typography.
    public enum Typography {

        /// Normal text and buttons.
        case label(weight: Font.Weight = .regular)

        @available(*, deprecated, message: "👨‍🎨 Design System: Please use any other value!")
        case custom(weight: Font.Weight = .regular, size: CGFloat = 17)
    }
}

extension DesignSystem.Typography {

    var designFont: Font {
        switch self {
        case .label(let weight):

            return font(weight: weight, size: 17)

        case .custom(let weight, let size):
            return font(weight: weight, size: size)
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
