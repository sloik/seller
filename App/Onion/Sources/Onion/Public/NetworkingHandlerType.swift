
// System
import Foundation

// Local

// 3rd party
import HTTPTypes

public protocol NetworkingHandlerType {

    func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)
}

// MARK: - Mock

public final class MockNetworkingHandler: NetworkingHandlerType {

    public init() {}

    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        fatalError("MockNetworkingHandler.run not implemented")
    }
}
