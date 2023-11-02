
import Foundation
import HTTPTypes

/// generic http Swift api client using protocols and generics
public protocol APIClientType {

    /// base url for the api client
    var baseURL: URL { get }

    /// Send a request to the server
    ///
    /// If the request is `GET` then body is ignored.
    func get<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)

    /// Uploads data to a resource.
    func upload<R: UploadRequest>(_ request: R) async throws -> (R.Output, HTTPResponse)
}
