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
        components.queryItems = []
               
        let queryItems: [(name: String, value: String?)] = [
            ("limit", String(limit)),
            ("offset", String(offset)),
            ("before", before),
            ("after", after)
        ]

        components.queryItems?.append(contentsOf: queryItems.compactMap { name, value in
            value.map { URLQueryItem(name: name, value: $0) }
        })
        
        if let componentsURL = components.url?.absoluteString {
            return componentsURL
        } else {
            return defaultPath
        }
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
