
import SwiftUI

struct InterlocutorAvatar {
    let interlocutor: Interlocutor?

    private let circleWidth = 63.0
    private let horizontalPadding = 13.0
}

extension InterlocutorAvatar: View {

    var body: some View {
        AsyncImage(url: interlocutor?.avatarUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .foregroundColor(Color.gray)
        }
        .frame(width: circleWidth, height: circleWidth)
        .design(padding: .custom(edges: .horizontal, length: horizontalPadding))
    }
}
