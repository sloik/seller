
import Foundation

extension DesignSystem {

    public enum Date {

        public static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = false
            return formatter
        }()

        public static let relativeDateTimeFormatter: RelativeDateTimeFormatter = {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .named
            formatter.unitsStyle = .full
            return formatter
        }()

        public static let isoDateFormatter: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            return formatter
        }()

        public enum Formatter {
            case relative
            case date
        }
    }
}

public extension String {

    /// Converts string representing ISO8601 Date to `Date`.
    var isoDate: Date? {
        DesignSystem.Date.isoDateFormatter.date(from: self)
    }
}

public extension Date {

    func design(formatter: DesignSystem.Date.Formatter) -> String {
        switch formatter {
        case .relative:
            return DesignSystem.Date.relativeDateTimeFormatter.localizedString(for: self, relativeTo: .now)
        case .date:
            return DesignSystem.Date.dateFormatter.string(from: self)
        }
    }
}
