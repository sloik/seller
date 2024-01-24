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
        self.viewModel.getAll()
    }

    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MessageNavigationView(viewModel: viewModel)
                    .frame(height: 77)
                ScrollView {
                    VStack(spacing: 17) {
                        ForEach(viewModel.threads) { (thread: MessageCenterThread) in

                            NavigationLink {
                                MessageDetailNavigationView(viewModel: factory.detailChatViewModel(thread: thread, messageCenter: viewModel.messageCenter))
                            } label: {
                                ThreadPreview(thread: thread)
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
//    ThreadsView(model: .init(networkingHandler: , tokenProvider: <#T##Producer<String?>##Producer<String?>##() -> String?#>))
//}
