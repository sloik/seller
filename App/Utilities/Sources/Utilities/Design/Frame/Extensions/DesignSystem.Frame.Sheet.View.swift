import SwiftUI

#if os(macOS)

public extension View {

    /// Modifies a view by setting it's frame when it's applicable.
    func design(sheet: DesignSystem.Frame.Sheet) -> some View {
        switch sheet {
        case .regular:
            return design(frame: .f800x800)
        case .small:
            return design(frame: .f300x400)
        }
    }
}

#endif
