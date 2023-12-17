
// system
import Foundation

// local
import Onion

// 3rd party
import HTTPTypes
import AliasWonderland

class MockURLSession: URLSessionType {

    var dataForRequestClosure: AsyncThrowsClosure<HTTPRequest, (Data, HTTPResponse)>!
    func data(for request: HTTPRequest) async throws -> (Data, HTTPResponse) {
        try await dataForRequestClosure(request)
    }

    func upload(for request: HTTPRequest, from bodyData: Data) async throws -> (Data, HTTPResponse) {
        fatalError("Not implemented")
    }
}
