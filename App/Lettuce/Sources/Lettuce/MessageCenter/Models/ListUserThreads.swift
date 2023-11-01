// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/listThreadsGET
public struct ListUserThreads: Codable, Equatable, ContentType, Paginated {
    public struct Thread: Codable, Equatable {
        public let id: String
        public let read: Bool
        public let lastMessageDateTime: String?
        
        public struct Interlocutor: Codable, Equatable {
            public let login: String
            public let avatarURL: String
            
            private enum CodingKeys: String, CodingKey {
                case login
                case avatarURL = "avatarUrl"
            }
        }
        public let interlocutor: Interlocutor?
    }
    public let threads: [Thread]
    public var offset: UInt
    public var limit: UInt
}
