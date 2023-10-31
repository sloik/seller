// system
import Foundation
import HTTPTypes

// local
import Onion

struct ListMessagesInThreadRequest: Request {
    typealias Output = [Message]
    
    var path: String {
        return preparePathWithComponents()
    }
    
   func preparePathWithComponents() -> String {
        var components = URLComponents()
        components.path = self.path
        components.queryItems = []
        
        if let limit = limit {
            components.queryItems?.append(URLQueryItem(name: "limit", value: String(limit)))
        }
        
        if let offset = offset {
            components.queryItems?.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        if let before = before {
            components.queryItems?.append(URLQueryItem(name: "before", value: before))
        }
        
        if let after = after {
            components.queryItems?.append(URLQueryItem(name: "after", value: after))
        }
        
        if components.queryItems != [], let componentsURL = components.url?.absoluteString {
            return componentsURL
        } else {
            return "/messaging/threads/\(threadId)/messages"
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
    
    let limit: Int?
    let offset: Int?
    let before: String?
    let after: String?
}

extension Array<Message>: ContentType {}
