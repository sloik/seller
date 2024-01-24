
import SwiftUI

struct LastMessageView: View {

    let message: Message

    private let fontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))

    var body: some View {
        Text(message.subject ?? message.text)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .truncationMode(.tail)
            .design(typography: .custom(weight: .semibold, size: 12))
            .foregroundColor(fontColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

