// system
import Foundation
import HTTPTypes

// local
import Onion

struct ListMessagesInThreadRequest: PaginatedRequest {

    struct PaginatedMessages: ContentType, Paginated {
        let offset: UInt
        let limit: UInt

        let messages: [Message]
    }

    typealias Output = PaginatedMessages
    
    var path: String {
        var components = URLComponents()
        let defaultPath = "/messaging/threads/\(threadId)/messages"

        components.path = defaultPath
        components.queryItems = filterDateQueryItems

        return components.url?.absoluteString ?? defaultPath
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .bearer(token),
            HTTPField.Name.accept : .applicationVndAllegroV1Json
        ]
    }
    
    let token: String
    let threadId: String
    
    let limit: UInt
    let offset: UInt
    let before: String?
    let after: String?

    internal init(
        token: String,
        threadId: String,
        limit: UInt = 20,
        offset: UInt = 0,
        before: String? = nil,
        after: String? = nil
    ) {
        self.token = token
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
