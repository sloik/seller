
import Foundation
import OSLog

import HTTPTypesFoundation
import HTTPTypes

private let logger = Logger(subsystem: "Onion", category: "Onion")

public protocol Request<Output> {

    /// Expected returned type.
    associatedtype Output: ContentType

    /// Path component for the request.
    var path: String { get }

    var headerFields: HTTPFields { get }
}

public extension Request {
    var headerFields: HTTPFields {
        [:]
    }
}

extension Request {
    func decode(_ resposne: Data) throws -> Output {
        let decoder = JSONDecoder()
        return try decoder.decode(Output.self, from: resposne)
    }
}

/// generic http sift api client using protocols and generics
public protocol APIClientType {

    /// base url for the api client
    var baseURL: URL { get }

    /// send a request to the server
    func get<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)
}

public final class APIClient: APIClientType {
    
    public var baseURL: URL


    private var baseRequest: HTTPRequest {
        HTTPRequest(
            method: .get,
            scheme: baseURL.scheme,
            authority: baseURL.host,
            path: baseURL.path,
            headerFields: [:]
        )
    }

    private let session: URLSession

    public init(
        baseURL: URL
    ) {
        self.baseURL = baseURL
        self.session = URLSession.shared
    }

    public func get<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {

        var httpRequest = baseRequest
        httpRequest.path = request.path
        httpRequest.headerFields = request.headerFields

        // TODO: add a retry count eg. max 3 times
        let (data, httpResponse) = try await session.data(for: httpRequest)

        guard
            case .successful = httpResponse.status.kind
        else {
            logger.error("Request \(type(of: request)) failed with response: \(httpResponse.debugDescription)")

            throw E.notSuccessStatus(status: httpResponse.status, data: data)
        }

        let output = try request.decode(data)

        return (output, httpResponse)

    }
}
