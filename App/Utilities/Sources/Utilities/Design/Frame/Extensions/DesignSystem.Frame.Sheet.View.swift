import SwiftUI

public extension View {

    /// Modifies a view by setting it's frame when it's applicable.
    func design(sheet: DesignSystem.Frame.Sheet) -> some View {
        switch sheet {
        case .regular:
            #if os(macOS)
            return design(frame: .f800x800)
            #else
            // Do not set any frame.
            return self
            #endif
        }
    }
}
