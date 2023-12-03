
import SwiftUI
import SweetBool
import OptionalAPI


public extension DesignSystem {
    enum Frame: Equatable {
        #if os(macOS)
        /// Default size for macOS windows.
        case window
        #endif

        /// 13x13 points frame.
        case f13x13

        /// 800x800 points frame.
        case f800x800
    }
}

extension DesignSystem.Frame {
    var size: CGSize {
        switch self {
        #if os(macOS)
        case .window:
            return CGSize(width: 800, height: 600)
        #endif

        case .f13x13:
            return CGSize(width: 13, height: 13)

        case .f800x800:
            return CGSize(width: 800, height: 800)
        }
    }

    /// True when case provides minimal size for a view.
    var isMinimal: Bool {
        var minimals: Set<Self> = []

        #if os(macOS)
        minimals.insert(.window)
        #endif

        return minimals.contains(self)
    }
}
