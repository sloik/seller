
import Foundation
import HTTPTypes

public protocol UploadRequest<Input>: Request {
    associatedtype Input: ContentType
    var body: Input { get }
}

public extension UploadRequest {
    var bodyData: Data {
        get throws {
            let encoder = JSONEncoder()
            return try encoder.encode(body)
        }
    }
}
