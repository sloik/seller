
import Foundation

import Onion

struct Attachment: ContentType {
    let fileName: String
    let mimeType: String?
    let url: String?

    enum Status: String, ContentType {
        case new = "NEW"
        case safe = "SAFE"
        case unsafe = "UNSAFE"
        case expired = "EXPIRED"
    }
    let status: Status
}
