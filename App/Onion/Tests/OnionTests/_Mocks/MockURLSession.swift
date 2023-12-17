
// system
import Foundation

// local
import Onion

// 3rd party
import HTTPTypes
import AliasWonderland

actor MockURLSession: URLSessionType {

    var dataForRequestCount = 0

    private var dataForRequestClosure: AsyncThrowsClosure<HTTPRequest, (Data, HTTPResponse)>!
    func setDataFor(_ closure: @escaping AsyncThrowsClosure<HTTPRequest, (Data, HTTPResponse)>) {
        dataForRequestClosure =  { request in
            self.dataForRequestCount += 1
            return try await closure(request)
        }
    }

    func data(for request: HTTPRequest) async throws -> (Data, HTTPResponse) {
        try await dataForRequestClosure(request)
    }

    func upload(for request: HTTPRequest, from bodyData: Data) async throws -> (Data, HTTPResponse) {
        fatalError("Not implemented")
    }
}
