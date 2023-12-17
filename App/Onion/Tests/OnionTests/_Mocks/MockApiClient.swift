
// system
import Foundation

// local
import Onion

// 3rd party
import HTTPTypes

class MockApiClient: APIClientType {

    public let baseURL: URL

    public init(baseURL: URL = URL(string: "https://fake.api.pl")!) {
        self.baseURL = baseURL
    }

    enum E: Error {
        case notMockRequest
    }

    var processedRequests: [MockRequest] = []
    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {

        guard let mockRequest = request as? MockRequest else {
            throw E.notMockRequest
        }

        processedRequests.append(mockRequest)

        return try mockRequest.response as! (R.Output, HTTPResponse)
    }

    public func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPTypes.HTTPResponse) {
        fatalError("Provide your own implementation of \(#function)")
    }
}
