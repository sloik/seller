
import SwiftUI

struct LastMessageView: View {
    @Environment(\.colorScheme) private var colorScheme
    let message: Message
    let read: Bool

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
            .foregroundColor(read ? .design(color: .gray2426, with: colorScheme).opacity(0.6)
                                  : .design(color: .gray2426, with: colorScheme))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
