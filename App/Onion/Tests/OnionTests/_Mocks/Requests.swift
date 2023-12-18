
import HTTPTypes

@testable import Onion
import Foundation
import AliasWonderland

protocol TagableType {
    var tag: String { get }

}

protocol ResponseProviderType: UploadRequest & TagableType {
    var response: (Output, HTTPResponse) { get throws }
}


struct JustRequest: Request {
    typealias Output = NetworkFlow.Response
    var path: String = "/"
}

struct AuthorizationRequest: Request {
    typealias Output = NetworkFlow.Response
    var path: String = "/"

    var headerFields: HTTPFields { [HTTPField.Name.authorization : .bearer("token")] }
}
