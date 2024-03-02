
import Foundation

import Onion
import OptionalAPI

struct Attachment: ContentType {
    let fileName: String

    enum MimeType: String, ContentType {
        case imagePng = "image/png"
        case imageJpeg = "image/jpeg"
        case pdf = "application/pdf"

        case unknown
    }
    let mimeType: MimeType?

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
        urlString.flatMap( URL.init(string:) )
    }


    var attachmentId: Identifier<Attachment>? {
        url
            .map( \.lastPathComponent )
            .map( Identifier<Attachment>.init(id:) )
    }
}

extension Attachment.MimeType: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        self = Attachment.MimeType(rawValue: rawValue) ?? .unknown
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
