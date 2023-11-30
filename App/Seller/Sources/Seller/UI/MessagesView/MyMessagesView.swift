// system
import SwiftUI

// Internal

// 3rd
import OptionalAPI

struct MessagesView: View {
    @ObservedObject private var viewModel = MyMessagesViewModel()
    @State private var shouldNavigate = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MessageNavigationView(viewModel: viewModel)
                    .frame(height: 77)
                ScrollView {
                    VStack(spacing: 17) {
                        NavigationLink(destination: MessageDetailNavigationView(viewModel: MessageDetailChatViewModel())) {
                            MessagePreview()
                                .padding(.top, 30)
                        }
                        NavigationLink(destination: MessageDetailNavigationView(viewModel: MessageDetailChatViewModel())) {
                            MessagePreview(hasAttachment: true)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MessagesView()
}
