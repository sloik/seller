
import SwiftUI

import Foundation

/// Provides namespace for different parts of design system.
public enum DesignSystem {

}


extension DesignSystem {

    enum Color {


        case lightGrayBackground

        var designColor: SwiftUI.Color {
            switch self {
            case .lightGrayBackground:
                return SwiftUI.Color(red: 0.95, green: 0.95, blue: 0.96)
            }
        }

    }

}
