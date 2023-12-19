
import HTTPTypes

@testable import Onion
import Foundation
import AliasWonderland

typealias TestsFlow = Flow

/// Type that is a `request` and `upload request` together with 
/// a definition of a response that should be returned from
/// the network.
class Flow {

    var tag: String = ""

    var request: FlowRequest

    var response: (FlowResponse, HTTPResponse) {
        get throws {
            try responseProducer!()
        }
    }

    // MARK: Configuration
    var responseProducer: ThrowsProducer<(FlowResponse, HTTPResponse)>?

    var responseData: (Data, HTTPResponse) {
        get throws {
            let (output, response) = try response
            return try (output.data, response)
        }
    }

    // MARK: Init
    init(request: FlowRequest) {
        self.request = request
    }
}

// MARK: - Request

struct FlowRequest: UploadRequest, Equatable {

    // MARK: Request
    typealias Output = FlowResponse

    var path: String = ""

    var headerFields: HTTPFields = [:]

    var method: HTTPRequest.Method = .get


    // MARK: UploadRequest
    typealias Input = String
    var body: Input
}


extension FlowRequest {

    /// Empty `Request` with a `String` body for `UploadRequest`.
    static var stringRequest: Self {
        FlowRequest(body: "Mock Request")
    }
}

// MARK: - Flow as Request

extension Flow: Request {
    typealias Output = FlowResponse

    var path: String { request.path }

    var headerFields: HTTPFields { request.headerFields }

    var method: HTTPRequest.Method { request.method }
}

// MARK: - Response

/// `ContentType` that is returned by the flow.
struct FlowResponse: ContentType, Equatable {
    static var mock: Self {
        FlowResponse(payload: "Mock Response")
    }

    let payload: String
}


// MARK: - Factory

extension Flow {
    static var okResponse: TestsFlow {
        let flow = TestsFlow(request: .stringRequest)

        flow.responseProducer = {
            (.mock, HTTPResponse(status: .ok))
        }
        flow.tag = "Ok Request"

        return flow
    }

    static var unauthorizedResponse: TestsFlow {
        let flow = TestsFlow(request: .stringRequest)

        flow.request.headerFields = [HTTPField.Name.authorization : .bearer("token")]
        flow.responseProducer = {
            (.mock, HTTPResponse(status: .unauthorized))
        }
        flow.tag = "Unauthorized Request"
        
        return flow
    }

    static var throwingResponse: TestsFlow {
        let flow = TestsFlow(request: .stringRequest)
        flow.responseProducer = { throw "Request failed!" }
        flow.tag = "Throwing Request"

        return flow
    }

    static var uploadResponse: TestsFlow{
        let flow = TestsFlow(request: .stringRequest)

        flow.responseProducer = {
            (.mock, HTTPResponse(status: .ok))
        }
        flow.tag = "Upload Request"
        flow.request.body = "Mock Upload Data"

        return flow
    }
}
