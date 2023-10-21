
import Foundation
import HTTPTypes

enum E: Error {

    enum HTTPTypeConversionError: Error {
        case failedToConvertURLResponseToHTTPResponse
    }

    /// Returned status is not from 200+ range.
    ///
    /// Contains `status` which is HTTP Response status and `data`.
    case notSuccessStatus(status: HTTPResponse.Status, data: Data)

    case unableToCreateURLRequest
}
