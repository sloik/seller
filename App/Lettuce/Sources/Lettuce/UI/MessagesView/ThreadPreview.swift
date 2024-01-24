// system
import SwiftUI

struct ThreadPreview {

    private let fontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
    private let circleWidth = 63.0
    private let circleLeftPadding = 30.0
    private let iconSize = 19.0
    private var hasAttachment: Bool = false
    private var hasUnreadMessages: Bool = false

    private let thread: ListUserThreads.Thread

    init(thread: ListUserThreads.Thread) {
        self.thread = thread
    }
}

extension ThreadPreview: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {

                    AsyncImage(url: thread.interlocutor?.avatarUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Circle()
                            .foregroundColor(Color.gray)
                    }
                    .frame(width: circleWidth, height: circleWidth)
                    .design(padding: .custom(edges: .leading, length: circleLeftPadding))
                    .design(padding: .base(.trailing))

                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text( thread.interlocutor?.login ?? "Unknown" )
                                    .font(.custom("SF Pro Display", fixedSize: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                HStack(alignment: .center, spacing: 0) {
                                    Image("attachmentIcon")
                                        .frame(width: iconSize, height: iconSize)
                                    Text("{offer:title}")
                                        .foregroundColor(fontColor)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .design(padding: .custom(edges: .top, length: 6))
                            }
                            Spacer()
                            VStack(spacing: 0) {
                                Text(thread.lastMessageDateTime ?? "--:--")
                                    .font(.custom("SF Pro Display", fixedSize: 14))
                                    .foregroundColor(fontColor)
                                if hasAttachment {
                                    ZStack {
                                        Circle()
                                            .frame(height: 23)
                                        Text("2")
                                            .font(.custom("SF Pro Display", fixedSize: 14))
                                            .foregroundColor(.white)
                                    }
                                    .design(padding: .custom(edges: .top, length: 4))
                                }
                            }
                        }
                        .padding(.trailing, 43)
                    }
                }
            }
        }
    }
}
