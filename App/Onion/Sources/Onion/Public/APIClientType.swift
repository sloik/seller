
import Foundation
import HTTPTypes

/// generic http Swift api client using protocols and generics
public protocol APIClientType {

    /// base url for the api client
    var baseURL: URL { get }

    /// send a request to the server
    func get<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)
}
