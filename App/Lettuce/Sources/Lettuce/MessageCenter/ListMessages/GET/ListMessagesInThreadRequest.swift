// system
import Foundation
import HTTPTypes

// local
import Onion

struct ListMessagesInThreadRequest: Request {
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
    
    var limit: Int = 20
    var offset: Int = 0
    let before: String?
    let after: String?
}

extension Array<Message>: ContentType {}
