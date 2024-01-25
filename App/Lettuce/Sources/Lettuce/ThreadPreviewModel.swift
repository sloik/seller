
import Foundation

import Zippy

final class ThreadPreviewModel {
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = false
        return formatter
    }()


    private let relativeDateTimeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .full
        return formatter
    }()

    private let isoDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

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
            .andThen( isoDateFormatter.date(from:) )
    }

    func lastMessageString(_ thread: MessageCenterThread) -> String? {
        lastMessageDate( thread )
            .andThen( dateFormatter.string(from:) )
    }

    func lastMessageRelativeString(_ thread: MessageCenterThread) -> String? {
        lastMessageDate( thread )
            .andThen { date in relativeDateTimeFormatter.localizedString(for: date, relativeTo: .now) }
    }
}
