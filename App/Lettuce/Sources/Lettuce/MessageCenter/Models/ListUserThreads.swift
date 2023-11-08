// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/listThreadsGET
struct ListUserThreads: ContentType, Paginated {
    struct Thread: Codable, Equatable {
        let id: String
        let read: Bool
        let lastMessageDateTime: String?
        let interlocutor: Interlocutor?
    }
    let threads: [Thread]
    let offset: UInt
    let limit: UInt
}
