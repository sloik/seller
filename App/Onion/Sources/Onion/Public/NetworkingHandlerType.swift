
// System
import Foundation

// Local

// 3rd party
import HTTPTypes

/// Type that is more specific to how given API works.
/// Should know how to retry failed requests also know how to re-login user.
public protocol NetworkingHandlerType {

    func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)
}
