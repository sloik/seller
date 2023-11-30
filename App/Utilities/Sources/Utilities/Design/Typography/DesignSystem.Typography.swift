
import SwiftUI

extension DesignSystem {

    /// Typography.
    public enum Typography {

        /// Normal text and buttons.
        case label(weight: Font.Weight = .regular, size: CGFloat = 17)
    }
}

extension DesignSystem.Typography {

    var designFont: Font {
        switch self {
        case .label(let weight, let size):
            Font.system(
                size: UIFontMetrics.default.scaledValue(for: size),
                weight: weight
            )
        }
    }

}
