// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/listThreadsGET
struct ListUserThreads: ContentType, Paginated {
    struct Thread: Codable, Equatable, Identifiable, Hashable, ContentType {
        let id: String
        let read: Bool
        let lastMessageDateTime: String?
        let interlocutor: Interlocutor?
    }
    let threads: [Thread]
    let offset: Int
    let limit: Int
}

/// Represents thread in message center.
typealias MessageCenterThread = ListUserThreads.Thread

extension MessageCenterThread {
    static var mock: MessageCenterThread {
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
