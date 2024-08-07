// system
import SwiftUI

// Internal
import Utilities

// 3rd
import OptionalAPI

struct ThreadsView: View {
    @Environment(LettuceFactory.self) private var factory

    @State private var model: ThreadsModel
    @State private var shouldNavigate = true

    init(model: ThreadsModel) {
        self.model = model
    }

    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MessageNavigationView(model: model)
                    .frame(height: 77)
                ScrollView {
                    VStack(spacing: 0) {

                        ForEach(
                            Array(model.threads.enumerated()),
                            id: \.element
                        ) { (index: Int, thread: MessageCenterThread) in
                            NavigationLink {
                                MessageDetailNavigationView(model: factory.detailChatModel(thread: thread))
                            } label: {
                                ThreadPreview(thread: thread)
                            }
                            .contextMenu {
                                if thread.read.isFalse {
                                    Button {
                                        model.markAsRead(thread)
                                    } label: {
                                        Label(String.localized("mark_as_read"), systemImage: "checkmark.message.fill")
                                    }
                                } else {
                                    Button {
                                        model.markAsUnread(thread)
                                    } label: {
                                        Label(String.localized("mark_as_unread"), systemImage: "checkmark.message")
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            model.getAll()
        }
    }
}

//#Preview {
//    ThreadsView(model: .init(networkingHandler: , tokenProvider: <#T##Producer<String?>##Producer<String?>##() -> String?#>))
//}
