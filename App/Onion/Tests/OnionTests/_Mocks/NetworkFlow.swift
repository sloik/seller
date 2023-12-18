
import HTTPTypes

@testable import Onion
import Foundation
import AliasWonderland

/// Type that is a `request` and `upload request` together with 
/// a definition of a response that should be returned from
/// the network.
class NetworkFlow: ResponseProviderType {

    // MARK: Request
    typealias Output = Response

    var path: String = ""

    var headerFields: HTTPFields = [:]

    var method: HTTPRequest.Method = .get


    // MARK: UploadRequest
    typealias Input = String
    var body: String = ""


    // MARK: TagableType
    var tag: String = ""


    // MARK: ResponseProviderType
    var response: (Output, HTTPResponse) {
        get throws {
            try responseProducer!()
        }
    }

    // MARK: Configuration
    var responseProducer: ThrowsProducer<(Output, HTTPResponse)>?


    // MARK: Init
    init(){}
}

// MARK: - Response

extension NetworkFlow {

    /// `ContentType` that is returned by the flow.
    struct Response: ContentType {
        static var mock: Response {
            Response(payload: "Mock Response")
        }

        let payload: String
    }
}


// MARK: - Factory

extension NetworkFlow {
    static var okResponse: NetworkFlow {
        let request = NetworkFlow()
        request.responseProducer = {
            (.mock, HTTPResponse(status: .ok))
        }
        request.tag = "Ok Request"
        return request
    }

    static var unauthorizedResponse: NetworkFlow {
        let request = NetworkFlow()
        request.headerFields = [HTTPField.Name.authorization : .bearer("token")]
        request.responseProducer = {
            (.mock, HTTPResponse(status: .unauthorized))
        }
        request.tag = "Unauthorized Request"
        return request
    }

    static var throwingResponse: NetworkFlow {
        let request = NetworkFlow()
        request.responseProducer = { throw "Request failed!" }
        request.tag = "Throwing Request"
        return request
    }

    static var uploadResponse: NetworkFlow {
        let request = NetworkFlow()
        request.responseProducer = {
            (.mock, HTTPResponse(status: .ok))
        }
        request.tag = "Upload Request"
        request.body = "Mock Upload Data"
        return request
    }
}
