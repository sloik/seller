
import SwiftUI

public extension View {

    /// Applies design system typography to view.
    func design(typography: DesignSystem.Typography) -> some View {
        self.font( typography.designFont )
    }
    
}
