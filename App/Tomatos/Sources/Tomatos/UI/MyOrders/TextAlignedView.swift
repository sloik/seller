
import SwiftUI

struct TextAlignedView: View {
    let key     : String
    let value   : String

    var body: some View {
        HStack {
            key
                .design(typography: .body(weight: .regular))
            value
                .design(typography: .body(weight: .regular))
                .alignmentGuide(.textAlignmentGuide) { context in
                    context[.leading]
                }

            // Fixed an issue when long values would not wrap.
            // I did try other solutions but none of them did the job.
            Spacer()
        }
    }
}
