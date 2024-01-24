
import SwiftUI

struct AttachmentIconView {

    private let iconSize = 19.0

}

extension AttachmentIconView: View {

    var body: some View {
        Image("attachmentIcon")
            .frame(width: iconSize, height: iconSize)
    }

}
