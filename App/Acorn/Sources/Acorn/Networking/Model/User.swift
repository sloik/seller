import Foundation

import Onion

struct User: ContentType, Identifiable, Equatable {
    let id: String
    let login: String
    let firstName: String
    let lastName: String
    let email: String
}
