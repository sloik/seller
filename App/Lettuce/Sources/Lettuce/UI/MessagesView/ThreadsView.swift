// system
import SwiftUI

// Internal
import Utilities

// 3rd
import OptionalAPI

struct ThreadsView: View {
    @Environment(LettuceFactory.self) private var factory

    @State private var viewModel: ThreadsViewModel
    @State private var shouldNavigate = true

    init(model: ThreadsViewModel) {
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
                            destination: MessageDetailNavigationView(viewModel: factory.detailChatViewModel(thread: .mock))
                        ) {
                            MessagePreview()
                                .design(padding: .bigger(.top))
                        }
                        NavigationLink(
                            destination: MessageDetailNavigationView(viewModel: factory.detailChatViewModel(thread: .mock))
                        ) {
                            MessagePreview(hasAttachment: true)
                        }

                        ForEach(viewModel.threads.threads) { (thread: ListUserThreads.Thread) in

                            NavigationLink {
                                MessageDetailNavigationView(viewModel: factory.detailChatViewModel(thread: thread))
                            } label: {
                                thread.interlocutor?.login ?? "Unknown"
                            }

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
