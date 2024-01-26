
import Foundation

import Utilities
import Zippy

final class ThreadPreviewModel {

    let thread: MessageCenterThread
    private let messageCenter: MessageCenterRepository

    init(
        thread: MessageCenterThread,
        messageCenter: MessageCenterRepository = LettuceFactory.shared.messageCenter
    ) {
        self.thread = thread
        self.messageCenter = messageCenter
    }

    var lastMessage: Message? {
        messageCenter.lastMessage(thread)
    }

    var hasAttachments: Bool {
        messageCenter.hasAttachments(thread)
    }

    var lastMessageTime: (relative: String, time: String)? {
        Zippy.zip(
            lastMessageRelativeString(thread),
            lastMessageString(thread)
        )
    }
}

private extension ThreadPreviewModel {

    func lastMessageDate(_ thread: MessageCenterThread) -> Date? {
        thread
            .lastMessageDateTime
            .andThen( \.isoDate )
    }

    func lastMessageString(_ thread: MessageCenterThread) -> String? {
        lastMessageDate( thread )
            .andThen { date in date.design(formatter: .date) }
    }

    func lastMessageRelativeString(_ thread: MessageCenterThread) -> String? {
        lastMessageDate( thread )
            .andThen { date in date.design(formatter: .relative) }
    }
}
