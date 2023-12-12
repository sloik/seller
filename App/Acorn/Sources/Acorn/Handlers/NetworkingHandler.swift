
// System
import Foundation
import OSLog

// Local
import Onion

// 3rd party
import HTTPTypes

private let logger = Logger(subsystem: "Acorn", category: "NetworkingHandler")

protocol NetworkingHandlerType {

    func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse)
}

final class NetworkingHandler {

    let apiClient: APIClientType

    init(
        apiClient: APIClientType
    ) {
        self.apiClient = apiClient
    }
}

extension NetworkingHandler: NetworkingHandlerType {

    func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        try await apiClient.run(request)
    }
}

// MARK: - Mock

final class MockNetworkingHandler: NetworkingHandlerType {

        func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
            fatalError("MockNetworkingHandler.run not implemented")
        }
}