// system
import SwiftUI

struct MessagesDetailChatView: View {

    var body: some View {
        VStack(spacing: 0) {
            MessageDetailNavigationView(viewModel: MessageDetailChatViewModel())
                .frame(height: 77)
            ScrollView {
                VStack(spacing: 17) {
                    MessagePreview()
                        .design(padding: .custom(edges: .top, length: 30))
                    MessagePreview(hasAttachment: true)
                }
            }
            Spacer()
        }
    }
}
