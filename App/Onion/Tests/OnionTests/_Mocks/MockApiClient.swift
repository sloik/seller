
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
        case notTestFlowRequest
    }

    var processedRequests: [TestsFlow] = []
    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {

        guard let testFlowRequest = request as? TestsFlow else {
            throw E.notTestFlowRequest
        }

        processedRequests.append(testFlowRequest)

        return try testFlowRequest.response as! (R.Output, HTTPResponse)
    }

    public func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPTypes.HTTPResponse) {
        fatalError("Provide your own implementation of \(#function)")
    }
}
