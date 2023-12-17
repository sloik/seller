
import Foundation
import HTTPTypes

/// Type that defines basic url for API and knows how to make a request.
public protocol APIClientType {

    /// base url for the api client
    var baseURL: URL { get }

    /// Send a request to the server
    ///
    /// If the request is `GET` then body is ignored.
    func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)

    /// Uploads data to a resource.
    func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPResponse)
}
