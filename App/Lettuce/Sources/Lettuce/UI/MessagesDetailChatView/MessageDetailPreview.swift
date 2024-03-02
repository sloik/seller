import SwiftUI

struct MessageDetailPreview: View {

    @Bindable var model: MessageDetailChatModel

    init(model: MessageDetailChatModel) {
        self.model = model
    }

    var body: some View {

        ForEach(model.messages) { message in
            VStack {
                message.text
                    .design(typography: .label(weight: .regular))
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: message.author.isInterlocutor ? .leading : .trailing
            )
        }
    }
}
