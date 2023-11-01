// system
import Foundation
import HTTPTypes

// local
import Onion

struct GetListUserThreads: PaginatedRequest {
    typealias Output = ListUserThreads
    
    var path: String {
        return preparePathWithComponents()
    }
    
    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : "Bearer \(token)",
            HTTPField.Name.contentType : "application/vnd.allegro.public.v1+json"
        ]
    }
    
    func preparePathWithComponents() -> String {
        var components = URLComponents()
        let defaultPath = "/messaging/threads"
        
        components.path = defaultPath
        components.queryItems = []
        
        let queryItems: [(name: String, value: String?)] = [
            ("limit", String(limit)),
            ("offset", String(offset)),
        ]
        
        components.queryItems?.append(contentsOf: queryItems.compactMap { name, value in
            value.map { URLQueryItem(name: name, value: $0) }
        })
        
        return components.url?.absoluteString ?? defaultPath
    }

    let token: String
    
    var offset: UInt
    var limit: UInt
    
    internal init(
        token: String,
        limit: UInt = 20,
        offset: UInt = 0
    ) {
        self.token = token
        self.limit = limit
        self.offset = offset
    }
}
