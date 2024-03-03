// system
import Foundation

// local
import Onion

struct Offer: ContentType, Identifiable, Hashable {
    let id: String
    let thumbnailUrl: String
    let name: String
    let url: String
}
