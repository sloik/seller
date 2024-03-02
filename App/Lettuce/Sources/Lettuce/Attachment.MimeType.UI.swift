
import SwiftUI

extension Attachment.MimeType {

    var asImage: Image {
        switch self {
        case .imagePng, .imageJpeg:
            return Image(systemName: "photo")
        case .pdf:
            return Image(systemName: "doc.text")

        case .unknown:
            return Image(systemName: "questionmark.app.dashed")
        }
    }
}
