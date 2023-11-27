
import SwiftUI

public extension View {

    func design(typography: DesignSystem.Typography) -> some View {
        self.font( typography.designFont )
    }
    
}
