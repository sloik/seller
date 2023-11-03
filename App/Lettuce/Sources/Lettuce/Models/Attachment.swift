
import Foundation

import Onion
import OptionalAPI

struct Attachment: ContentType {
    let fileName: String
    let mimeType: String?
    let urlString: String?

    enum Status: String, ContentType {
        case new = "NEW"
        case safe = "SAFE"
        case unsafe = "UNSAFE"
        case expired = "EXPIRED"
    }
    let status: Status

    enum CodingKeys: String, CodingKey {
        case fileName = "fileName"
        case mimeType = "mimeType"
        case urlString = "url"
        case status = "status"
    }
}

extension Attachment {
    var url: URL? {
       return urlString.flatMap( URL.init(string:) )
    }
}
