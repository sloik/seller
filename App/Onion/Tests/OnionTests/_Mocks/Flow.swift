
import HTTPTypes

@testable import Onion
import Foundation
import AliasWonderland

/// Type that is a `request` and `upload request` together with 
/// a definition of a response that should be returned from
/// the network.
///
/// `Flow` also conforms to `UploadRequest` so it can be used
/// as a `Request` object. All call are forwarded to appropriate
/// properties.
class Flow {
    
    /// Identifier for the flow.
    var tag: String = ""

    /// Request that should be used to run the flow.
    var request: FlowRequest

    /// Response that should be returned when running the flow.
    /// 
    /// This of this as a __backend response__ that contains
    /// the `data` (`FlowResponse`) and `response` (`HTTPResponse`).
    ///
    /// `responseProducer` closure is called each time accessing this property.
    var response: (FlowResponse, HTTPResponse) {
        get throws {
            try responseProducer!()
        }
    }

    // MARK: Configuration

    /// Closure called when `response` is accessed. 
    ///
    /// You can use this also as a point to rigger any other action in the
    /// test. As long as it returns the desired response.
    var responseProducer: ThrowsProducer<(FlowResponse, HTTPResponse)>?

    /// Response that should be returned when running the flow.
    ///
    /// This of this as a __backend response__ that contains
    /// the `data` (`Data`) and `response` (`HTTPResponse`).
    /// This form of response is more close to the bottom parts
    /// of the stack (before `Codable` is used).
    ///
    /// `responseProducer` closure is called each time accessing this property.
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


/// Type used for describing all requests in tests.
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

extension Flow: UploadRequest {


    // MARK: Request
    typealias Output = FlowResponse

    var path: String { request.path }

    var headerFields: HTTPFields {
        get {
            request.headerFields
        }
        set {
            request.headerFields = newValue
        }
    }

    var method: HTTPRequest.Method { request.method }

    // MARK: UploadRequest
    typealias Input = FlowRequest.Input

    var body: String {
        request.body
    }

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
    static var okResponse: Flow {
        let flow = Flow(request: .stringRequest)

        flow.responseProducer = {
            (.mock, HTTPResponse(status: .ok))
        }
        flow.tag = "Ok Request"

        return flow
    }

    static var unauthorizedResponse: Flow {
        let flow = Flow(request: .stringRequest)

        flow.request.headerFields = [HTTPField.Name.authorization : .bearer("token")]
        flow.responseProducer = {
            (.mock, HTTPResponse(status: .unauthorized))
        }
        flow.tag = "Unauthorized Request"
        
        return flow
    }

    static var throwingResponse: Flow {
        let flow = Flow(request: .stringRequest)
        flow.responseProducer = { throw "Request failed!" }
        flow.tag = "Throwing Request"

        return flow
    }

    static var uploadResponse: Flow {
        let flow = Flow(request: .stringRequest)

        flow.responseProducer = {
            (.mock, HTTPResponse(status: .ok))
        }
        flow.tag = "Upload Request"
        flow.request.body = "Mock Upload Data"

        return flow
    }
}
