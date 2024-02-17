
// system
import Foundation

// local
import Onion

struct JsonURL: ContentType {
    let url: String
}

extension JsonURL {
    var asURL: URL? {
        URL(string: url)
    }
}
