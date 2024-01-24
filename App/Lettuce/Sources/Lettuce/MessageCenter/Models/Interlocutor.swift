// system
import Foundation
import HTTPTypes

// local
import Onion

struct Interlocutor: ContentType, Hashable {
    let login: String
    let avatarUrlString: String

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrlString = "avatarUrl"
    }
}

extension Interlocutor {
    var avatarUrl: URL? {
        URL(string: avatarUrlString)
    }
}
