// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/listThreadsGET
struct ListUserThreads: ContentType, Paginated {
    struct Thread: Codable, Equatable, Identifiable, Hashable {
        let id: String
        let read: Bool
        let lastMessageDateTime: String?
        let interlocutor: Interlocutor?
    }
    let threads: [Thread]
    let offset: UInt
    let limit: UInt
}

extension ListUserThreads.Thread {
    static var mock: ListUserThreads.Thread {
        .init(
            id: "1",
            read: false, 
            lastMessageDateTime: .none,
            interlocutor: .none
        )
    }
}

extension ListUserThreads {
    static var mock: Self {
        .init(threads: [.mock, .mock], offset: 0, limit: 0)
    }

    static var empty: Self {
        .init(threads: [], offset: 0, limit: 0)
    }
}
