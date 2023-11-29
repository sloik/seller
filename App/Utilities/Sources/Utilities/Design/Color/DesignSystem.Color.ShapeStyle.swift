
import SwiftUI

public extension ShapeStyle where Self == Color {

    /// Applies design system color to shape style.
    static func design(color: DesignSystem.Color, with scheme: ColorScheme) -> Self {
        color.with( scheme )
    }

}
