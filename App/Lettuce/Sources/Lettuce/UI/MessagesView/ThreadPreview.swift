// system
import SwiftUI

import Zippy

struct ThreadPreview {
    private let fontColor = (Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))

    private var hasAttachment: Bool = false
    private var hasUnreadMessages: Bool = false

    private let model: ThreadPreviewModel

    init(thread: MessageCenterThread) {
        self.model = ThreadPreviewModel(thread: thread)
    }
}

extension ThreadPreview: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {

                    ZStack {
                        InterlocutorAvatar(interlocutor: model.thread.interlocutor)

                        if model.thread.read.isFalse {
                            GreenOnlineCircle()
                        }
                    }

                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text( model.thread.interlocutor?.login ?? "Unknown" )
                                    .font(.custom("SF Pro Display", fixedSize: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                HStack(alignment: .center, spacing: 0) {

                                    if model.hasAttachments {
                                        AttachmentIconView()
                                    }

                                    if let message = model.lastMessage {
                                        LastMessageView(message: message)
                                    }
                                }
                                .design(padding: .custom(edges: .top, length: 6))
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 0) {

                                if let times = model.lastMessageTime {

                                    times.relative
                                        .font(.custom("SF Pro Display", fixedSize: 14))
                                        .foregroundColor(fontColor)

                                    times.time
                                        .font(.custom("SF Pro Display", fixedSize: 14))
                                        .foregroundColor(fontColor)
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
