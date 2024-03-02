
import Foundation

// https://api.{environment}

// system
import Foundation
import HTTPTypes

// local
import Onion
import Utilities

struct DownloadAttachmentDataRequest: Request {
    typealias Output = Data

    var path: String {
        "/messaging/message-attachments/\(attachmentId)"
    }

    var headerFields: HTTPFields = [
        HTTPField.Name.accept : "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
    ]

    let attachmentId: String

    internal init(
        attachmentId: String
    ) {
        self.attachmentId = attachmentId
    }
}
