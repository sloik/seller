
import Foundation
import HTTPTypes

enum E: Error {

    enum HTTPTypeConversionError: Error {
        case failedToConvertURLResponseToHTTPResponse
    }

    case unableToCreateURLRequest
}
