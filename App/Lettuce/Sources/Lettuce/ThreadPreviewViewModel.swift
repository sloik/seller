
import Foundation

import Zippy

final class ThreadPreviewViewModel {
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

    init(thread: MessageCenterThread) {
        self.thread = thread
    }

    var lastMessageTime: (relative: String, time: String)? {
        Zippy.zip(
            lastMessageRelativeString(thread),
            lastMessageString(thread)
        )
    }
}

private extension ThreadPreviewViewModel {

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
