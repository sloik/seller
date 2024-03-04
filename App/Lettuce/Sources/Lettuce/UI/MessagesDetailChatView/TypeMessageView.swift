import SwiftUI

internal struct MessageSpacer: View {
        var body: some View {
            Spacer()
                .frame(height: 10)
        }
    }

internal struct TypeMessageView: View {

        @Bindable private var model: MessageDetailChatModel

        init(model: MessageDetailChatModel) {
            self.model = model
        }

        var body: some View {
            VStack {
                Divider()
                HStack(spacing: 0) {

                    Button(action: {
                        print("Attachment clicked")
                    }, label: {
                        Image(systemName: "paperclip")
                            .design(padding: .large(.horizontal))
                    })

                    TextField("Type a message", text: $model.conversationMessage, axis: .vertical)
                        .lineLimit(model.conversationLineLimit)
                        .design(padding: .large(.leading))
                    Spacer()

                    Button(action: {
                        Task {
                            await model.sendMessageInThread()
                        }
                    }, label: {
                        Image(systemName: "paperplane.fill")
                            .design(padding: .large(.horizontal))
                    })
                }
                .frame(height: 78)
                .background(Color.white)
            }
        }
    }

