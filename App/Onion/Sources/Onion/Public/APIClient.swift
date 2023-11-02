

import Foundation
import OSLog

import HTTPTypesFoundation
import HTTPTypes

public final class APIClient: APIClientType {

    public var baseURL: URL

    private var baseRequest: HTTPRequest {
        HTTPRequest(
            method: .get,
            url: baseURL,
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
        logger.debug("Sending request \(type(of: request))")

        let httpRequest = httpRequest(from: request)

        let (data, httpResponse) = try await session.data(for: httpRequest)

        return try commonValidationAndDecode(request: request, data: data, httpResponse: httpResponse)
    }


private extension APIClient {

    func commonValidationAndDecode<R: Request>(request: R, data: Data, httpResponse: HTTPResponse) throws -> (R.Output, HTTPResponse) {

        guard
            case .successful = httpResponse.status.kind
        else {
            logger.error("Request \(type(of: request)) failed with response: \(httpResponse.debugDescription)")

            throw E.notSuccessStatus(status: httpResponse.status, data: data)
        }

        let output = try request.decode(data)

        return (output, httpResponse)
    }

    func httpRequest<R: Request>(from request: R) -> HTTPRequest {

        var httpRequest = baseRequest
        httpRequest.path = request.path
        httpRequest.headerFields = request.headerFields
        httpRequest.method = request.method

        return httpRequest
    }

    /// Fetches request and in case of errors retries is to total of 3 times.
    func trieToLoad(request: HTTPRequest) async throws -> (Data, HTTPResponse) {

        // Tries to get the data for a request 2 times
        for _ in 1...2 {
            do {
                return try await session.data(for: request)
            } catch {
                // ignore the error now
                continue
            }
        }

        // Trie it 3rd and last time
        return try await session.data(for: request)
    }
}
