
import SwiftUI

public extension View {

    /// Applies design system padding to view.
    func design(padding: DesignSystem.Padding) -> some View {
        self.padding(padding.edges, padding.length)
    }

    /// Applies design system padding to view.
    func design(padding pad1: DesignSystem.Padding, padding pad2: DesignSystem.Padding) -> some View {
        self
            .padding(pad1.edges, pad1.length)
            .padding(pad2.edges, pad2.length)
    }
}
