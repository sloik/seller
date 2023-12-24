
import Foundation
import HTTPTypes

public protocol UploadRequest<Input>: Request {
    associatedtype Input: ContentType
    var body: Input { get }
}
