
import Foundation

import HTTPTypes

public enum OnionError: Error {

    case invalidRequestParameters(String)

    /// Returned status is not from 200+ range.
    ///
    /// Contains `response` and `data`.
    case notSuccessStatus(response: HTTPResponse, data: Data)
}
