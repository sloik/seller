// system
import Foundation
import HTTPTypes

// local
import Onion

struct ListMessagesInThreadRequest: PaginatedRequest {

    typealias Output = MessagesInThread

    var path: String {
        "/messaging/threads/\(threadId)/messages"
            .appendToPath(items: filterDateQueryItems)
    }
    
    var headerFields: HTTPFields = [
        HTTPField.Name.accept : .applicationVndAllegroV1Json
    ]

    let threadId: String
    
    let limit: UInt
    let offset: UInt
    let before: String?
    let after: String?

    internal init(
        threadId: String,
        limit: UInt = 20,
        offset: UInt = 0,
        before: String? = nil,
        after: String? = nil
    ) {
        self.threadId = threadId
        self.limit = limit
        self.offset = offset
        self.before = before
        self.after = after
    }
}

private extension ListMessagesInThreadRequest {

    var filterDateQueryItems: [URLQueryItem] {
        var items = paginationQueryItems

        if let before {
            items.append(URLQueryItem(name: "before", value: before))

            // Message creation date before filter parameter (exclusive) - cannot be used with offset.
            items.removeAll(where: { $0.name == "offset" })
        }
        if let after { items.append(URLQueryItem(name: "after", value: after)) }

        return items
    }
}
