// system
import Foundation
import HTTPTypes

// local
import Onion

struct ListMessagesInThreadRequest: PaginatedRequest {
    typealias Output = [Message]
    
    var path: String {
        preparePathWithComponents()
    }
    
    func preparePathWithComponents() -> String {
        var components = URLComponents()
        let defaultPath = "/messaging/threads/\(threadId)/messages"

        components.path = defaultPath
        components.queryItems = paginationQueryItems + filterDateQueryItems

        return components.url?.absoluteString ?? defaultPath
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : "Bearer \(token)",
            HTTPField.Name.contentType : "application/vnd.allegro.public.v1+json"
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
        var items = [URLQueryItem]()

        if let before { items.append(URLQueryItem(name: "before", value: before)) }
        if let after { items.append(URLQueryItem(name: "after", value: after)) }

        return items
    }
}
