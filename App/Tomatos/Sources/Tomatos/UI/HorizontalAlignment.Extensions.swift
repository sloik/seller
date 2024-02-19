
import SwiftUI

extension HorizontalAlignment {

    private struct TextAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.leading]
        }
    }

    static let textAlignmentGuide = HorizontalAlignment(
        TextAlignment.self
    )
}
