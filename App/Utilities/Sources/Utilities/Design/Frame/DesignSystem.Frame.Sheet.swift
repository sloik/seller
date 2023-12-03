
import SwiftUI

// For now it looks like Sheets are needed only on macOS as default
// presentation does not look good.
#if os(macOS)
public extension DesignSystem.Frame {

    /// Defines sheet sizes.
    enum Sheet {

        /// Small size for action
        case small

        /// Default size for sheets
        case regular
    }
}
#endif
