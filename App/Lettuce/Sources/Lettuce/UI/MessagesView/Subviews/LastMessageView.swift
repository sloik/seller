
import SwiftUI

struct LastMessageView: View {

    let message: Message
    let read: Bool

    private let fontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
    private let readFontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(1.0))

    var body: some View {
        Text(message.subject ?? message.text)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .truncationMode(.tail)
            .design(
                typography: .custom(
                    weight: read ? .regular : .bold,
                    size: 12
                )
            )
            .foregroundColor(read ? fontColor : readFontColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
