
import Foundation
import HTTPTypes

enum E: Error {

    enum HTTPTypeConversionError: Error {
        case failedToConvertURLResponseToHTTPResponse
    }

    /// Returned status is not from 200+ range.
    ///
    /// Contains `response` and `data`.
    case notSuccessStatus(response: HTTPResponse, data: Data)

    case unableToCreateURLRequest
}
