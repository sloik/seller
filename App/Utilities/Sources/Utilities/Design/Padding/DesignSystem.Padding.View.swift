
import SwiftUI

public extension View {

    /// Applies design system padding to view.
    func design(padding: DesignSystem.Padding) -> some View {
        self.padding(padding.edges, padding.length)
    }
}
