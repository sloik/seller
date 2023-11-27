
import SwiftUI

public extension ShapeStyle where Self == Color {

    static func design(color: DesignSystem.Color, with scheme: ColorScheme) -> Self {
        color.designColor(with: scheme)
    }

}
