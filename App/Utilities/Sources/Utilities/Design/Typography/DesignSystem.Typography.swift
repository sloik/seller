
import SwiftUI

extension DesignSystem {

    /// Typography.
    public enum Typography {

        /// Normal text and buttons.
        case label(weight: Font.Weight = .regular)
    }
}

extension DesignSystem.Typography {

    var designFont: Font {
        switch self {
        case .label(let weight):
            Font.system(
                size: UIFontMetrics.default.scaledValue(for: 17),
                weight: weight
            )
        }
    }

}
