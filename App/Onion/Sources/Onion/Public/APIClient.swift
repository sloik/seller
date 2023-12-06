

import Foundation
import OSLog

import HTTPTypesFoundation
import HTTPTypes

import AliasWonderland

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

    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        logger.debug("Sending request \(type(of: request)) \(self.baseURL.absoluteString)\(request.path)")

        let httpRequest = httpRequest(from: request)

        let (data, httpResponse) = try await tryToLoad {
            try await session.data(for: httpRequest)
        }

        return try commonValidationAndDecode(request: request, data: data, httpResponse: httpResponse)
    }

    public func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        logger.debug("Sending request \(type(of: request))")

        let httpRequest = httpRequest(from: request)

        let (data, httpResponse) = try await tryToLoad {
            try await session.upload(for: httpRequest, from: request.bodyData)
        }

        return try commonValidationAndDecode(request: request, data: data, httpResponse: httpResponse)
    }
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

    /// Runs `action` and in case of errors retries is to total of 3 times.
    func tryToLoad<A,B>(action: AsyncThrowsProducer2O<A,B>) async throws -> (A, B) {

        // Tries to get the data for a request 2 times
        for _ in 1...2 {
            do {
                return try await action()
            } catch {
                // ignore the error now
                continue
            }
        }

        // try it 3rd and last time
        return try await action()
    }
}

// MARK: -

open class MockApiClient: APIClientType {

   public let baseURL: URL

    public init(baseURL: URL = URL(string: "https://fake.api.pl")!) {
        self.baseURL = baseURL
    }

    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        fatalError("Provide your own implementation of \(#function)")
    }

    public func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPTypes.HTTPResponse) {
        fatalError("Provide your own implementation of \(#function)")
    }
}
