// system
import SwiftUI

// Internal
import Utilities

// 3rd
import OptionalAPI

struct MessagesView: View {
    @Environment(LettuceFactory.self) private var factory

    @State private var viewModel: MyMessagesViewModel
    @State private var shouldNavigate = true

    init(model: MyMessagesViewModel) {
        self.viewModel = model
    }

    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MessageNavigationView(viewModel: viewModel)
                    .frame(height: 77)
                ScrollView {
                    VStack(spacing: 17) {
                        NavigationLink(
                            destination: MessageDetailNavigationView(viewModel: factory.detailChatViewModel())
                        ) {
                            MessagePreview()
                                .design(padding: .bigger(.top))
                        }
                        NavigationLink(
                            destination: MessageDetailNavigationView(viewModel: factory.detailChatViewModel())
                        ) {
                            MessagePreview(hasAttachment: true)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

//#Preview {
//    MessagesView()
//}
