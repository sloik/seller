
import Foundation

import HTTPTypes
import Onion

struct MockApiClient: APIClientType {
    var baseURL: URL = URL(string: "https://fake.api.pl")!

    func run<R>(_ request: R) async throws -> (R.Output, HTTPTypes.HTTPResponse) where R : Onion.Request {
        fatalError()
    }

    func upload<R>(_ request: R) async throws -> (R.Output, HTTPTypes.HTTPResponse) where R : Onion.UploadRequest {
        fatalError()
    }
}

struct MockNetworkingHandler: NetworkingHandlerType {
    func run<R>(_ request: R) async throws -> (R.Output, HTTPTypes.HTTPResponse) where R : Onion.Request {
        fatalError()
    }
}
