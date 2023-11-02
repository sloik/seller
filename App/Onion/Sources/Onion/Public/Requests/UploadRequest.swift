
import Foundation
import HTTPTypes

public protocol UploadRequest: Request {
    var body: any ContentType { get }
}

public extension UploadRequest {
    var method: HTTPRequest.Method {
        .post
    }

    var bodyData: Data {
        get throws {
            let encoder = JSONEncoder()
            return try encoder.encode(body)
        }
    }
}
