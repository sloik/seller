
import Foundation

import HTTPTypes

import Onion

struct DownloadAttachmentDataRequest: Request {

    typealias Output = Data

    var path: String {
        url.absoluteString
    }

    var method: HTTPRequest.Method {
        .get
    }

    var headerFields: HTTPFields = [:]

    let url: URL

    internal init(
        url: URL
    ) {
        self.url = url
    }
}
