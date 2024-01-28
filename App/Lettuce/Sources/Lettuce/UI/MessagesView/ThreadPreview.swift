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

                    InterlocutorAvatar(interlocutor: model.thread.interlocutor)
                        .design(padding: .smaller(.vertical))

                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text( model.thread.interlocutor?.login ?? "Unknown" )
                                    .font(.custom("SF Pro Display", fixedSize: 17))
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                HStack(alignment: .center, spacing: 0) {

                                    if let message = model.lastMessage {
                                        LastMessageView(message: message, read: model.thread.read)
                                    }
                                }
                                .design(padding: .custom(edges: .top, length: 6))
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {

                                if let times = model.lastMessageTime {

                                    times.relative
                                        .design(
                                            typography: .custom(
                                                weight: model.thread.read ? .regular : .medium  ,
                                                size: 14
                                            )
                                        )
                                        .foregroundColor(model.thread.read ? fontColor : .black)

                                    times.time
                                        .design(
                                            typography: .custom(
                                                weight: model.thread.read ? .regular : .medium  ,
                                                size: 14
                                            )
                                        )
                                        .foregroundColor(model.thread.read ? fontColor : .black)
                                }


                            }
                        }
                        .design(padding: .smaller(.trailing))
                    }
                }
            }
        Divider()
                .frame(height: 1)
        }
    }
}
