
import Foundation

import HTTPTypesFoundation
import HTTPTypes

protocol APIClientType {
    func send(_ request: HTTPRequest) async throws -> HTTPResponse
}

enum E: Error {

    enum HTTPTypeConversionError: Error {
        case failedToConvertURLResponseToHTTPResponse
    }

    case unableToCreateURLRequest
}

final class APIClient: APIClientType {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        guard
            let urlRequest = URLRequest(httpRequest: request)
        else {
            throw E.unableToCreateURLRequest
        }

        let (data, urlResponse) = try await session.data(for: urlRequest)
        guard 
            let response = (urlResponse as? HTTPURLResponse)?.httpResponse
        else {
            throw E.HTTPTypeConversionError.failedToConvertURLResponseToHTTPResponse
        }
        return response
    }
}
