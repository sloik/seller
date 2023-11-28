import Foundation

import HTTPTypes

import Onion

//https://developer.allegro.pl/documentation#operation/uploadAttachmentPUT
public struct DownloadAttchmentRequest {

    let attachmentId: Identifier<Attachment>

    var path: String { "/messaging/message-attachments/\(attachmentId.id)" }

    var method: HTTPRequest.Method { .get }

    var headerFields: HTTPFields {
        var fields: HTTPFields = [:]

        fields[token.httpField.name] = token.httpField.value

        return fields
    }

    let token: BearerToken
}
