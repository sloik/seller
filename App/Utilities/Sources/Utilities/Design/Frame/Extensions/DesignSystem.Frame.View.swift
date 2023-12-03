
import SwiftUI

public extension View {

    /// Modifies a view by setting it's frame when it's applicable.
    func design(minFrame: DesignSystem.Frame) -> some View {
        frame(
            minWidth: minFrame.size.width,
            minHeight: minFrame.size.height
        )
    }

    /// Modifies a view by setting it's frame when it's applicable.
    func design(frame: DesignSystem.Frame) -> some View {
        self.frame(
            width: frame.size.width,
            height: frame.size.height
        )
    }
}
