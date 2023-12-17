

import Foundation
import OSLog

import Utilities

import HTTPTypesFoundation
import HTTPTypes

import AliasWonderland

private let logger = Logger(subsystem: "Onion", category: "API Client")

public protocol URLSessionType {
    func data(for request: HTTPRequest) async throws -> (Data, HTTPResponse)
    func upload(for request: HTTPRequest, from bodyData: Data) async throws -> (Data, HTTPResponse)
}

extension URLSession: URLSessionType {}

public final class APIClient: APIClientType {

    public var baseURL: URL

    private var baseRequest: HTTPRequest {
        HTTPRequest(
            method: .get,
            url: baseURL,
            headerFields: [:]
        )
    }

    private let session: URLSessionType

    public init(
        baseURL: URL,
        session: URLSessionType = URLSession.shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }

    @discardableResult
    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {

        let requestID = UUID()

        logger.debug("\(type(of: self)) \(#function) \(requestID)> Sending request \(type(of: request)) \(self.baseURL.absoluteString)\(request.path)")

        let httpRequest = httpRequest(from: request)

        let (data, httpResponse) = try await session.data(for: httpRequest)

        logger.debug("\(type(of: self)) \(#function) \(requestID)> Response: \(httpResponse.debugDescription)")
        logger.debug("\(type(of: self)) \(#function) \(requestID)>     Data: \(String(data: data, encoding: .utf8) ?? "-")")

        return try commonValidationAndDecode(request: request, data: data, httpResponse: httpResponse)
    }

    public func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        logger.debug("\(type(of: self)) \(#function)> Sending request \(type(of: request))")

        let httpRequest = httpRequest(from: request)

        let (data, httpResponse) = try await session.upload(for: httpRequest, from: request.bodyData)

        return try commonValidationAndDecode(request: request, data: data, httpResponse: httpResponse)
    }
}

private extension APIClient {

    func commonValidationAndDecode<R: Request>(request: R, data: Data, httpResponse: HTTPResponse) throws -> (R.Output, HTTPResponse) {

        guard
            case .successful = httpResponse.status.kind
        else {
            logger.error("\(type(of: self)) \(#function)> Request \(type(of: request)) failed with response: \(httpResponse.debugDescription)")

            throw OnionError.notSuccessStatus(response: httpResponse, data: data)
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
}
