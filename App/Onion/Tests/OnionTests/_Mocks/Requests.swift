
import HTTPTypes

@testable import Onion
import Foundation
import AliasWonderland

struct MockResponse: ContentType {
    
    static var mock: MockResponse {
        MockResponse(payload: "Mock Response")
    }

    let payload: String
}

protocol MockRequestType: Request {
    var response: (Output, HTTPResponse) { get }
    var tag: String { get }
}


class MockRequest: MockRequestType {
    typealias Output = MockResponse
    var path: String = ""

    var tag: String = "MockRequest"

    var responseProducer: Producer<(Output, HTTPResponse)>?
    var response: (Output, HTTPResponse) {
        responseProducer!()
    }

    var headerFields: HTTPFields = [:]

    init(){}
}

extension MockRequest {
    static var okResponse: MockRequest {
        let request = MockRequest()
        request.responseProducer = {
            (.mock, HTTPResponse(status: .ok))
        }
        request.tag = "Ok Request"
        return request
    }

    static var unauthorizedResponse: MockRequest {
        let request = MockRequest()
        request.headerFields = [HTTPField.Name.authorization : .bearer("token")]
        request.responseProducer = {
            (.mock, HTTPResponse(status: .unauthorized))
        }
        request.tag = "Unauthorized Request"
        return request
    }
}


struct JustRequest: Request {
    typealias Output = MockResponse
    var path: String = "/"
}

struct AuthorizationRequest: Request {
    typealias Output = MockResponse
    var path: String = "/"

    var headerFields: HTTPFields { [HTTPField.Name.authorization : .bearer("token")] }
}
