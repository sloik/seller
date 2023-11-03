
import Foundation

import HTTPTypes

import Onion

// https://developer.allegro.pl/documentation#operation/uploadAttachmentPUT
struct UploadAttachmentRequest: UploadRequest {
    typealias Input = Data
    typealias Output = Identifier<Attachment>

    var path: String {
        "/messaging/message-attachments/\(attachmentId.id)"
    }

    var method: HTTPRequest.Method {
        .put
    }

    var headerFields: HTTPFields {
        [
            HTTPField.Name.authorization : .bearer(token),
            HTTPField.Name.contentType : attachmentType.rawValue
        ]
    }

    let token: String
    let attachmentId: Identifier<Attachment>

    enum AttachmentType: String, ContentType {
        case png = "image/png"
        case jpeg = "image/jpeg"
        case gif = "image/gif"
        case tiff = "image/tiff"
        case bmp = "image/bmp"
        case pdf = "application/pdf"
    }
    let attachmentType: AttachmentType
    let attachmentData: Data

    var body: Data { attachmentData }
}
