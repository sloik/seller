import SwiftUI

import AliasWonderland

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

                AddAttachmentView()
                    .frame(width: 30)

                TextField(String.localized("type_message"), text: $model.conversationMessage, axis: .vertical)
                    .lineLimit(model.conversationLineLimit)
                    .design(padding: .bigger(.leading))
                    .fixedSize(horizontal: false, vertical: true)

                SendMessageButton {
                    await model.sendMessageInThread()
                }
                .frame(width: 30)
            }
            .frame(height: 78)
            .background(Color.white)
            .padding()
        }
    }
}

struct AddAttachmentView: View {
    var body: some View {
        Menu {
            Button(String.localized("camera")) {
                print("Camera clicked")
            }
            Button(String.localized("photo_library")) {
                print("Photo Library clicked")
            }
            Button(String.localized("document")) {
                print("Document clicked")
            }
        } label: {
            Image(systemName: "paperclip")
                .design(padding: .large(.horizontal))
        } primaryAction: {
            print("Run default action...")
        }
    }
}

struct SendMessageButton: View {

    let action: () async -> Void

    var body: some View {
        Button(action: {
            Task {
                await action()
            }
        }, label: {
            Image(systemName: "paperplane.fill")
                .design(padding: .large(.horizontal))
        })
    }
}
