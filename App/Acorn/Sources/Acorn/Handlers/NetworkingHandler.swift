
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

    let loginHandler: LoginHandlerType

    init(
        apiClient: APIClientType,
        loginHandler: LoginHandlerType
    ) {
        self.apiClient = apiClient
        self.loginHandler = loginHandler
    }
}

enum NetworkingHandlerError: Error {

    /// Thrown when refresh token request does not provide a valid token.
    case unableToRefreshToken(underlyingError: Error)
}

extension NetworkingHandler: NetworkingHandlerType {

    func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        if request.authorizationWithJWTNeeded {
             try await tryToRunAndRefreshTokenWhenNeeded(request)
        } else {
             try await apiClient.run(request)
        }
    }
}

private extension NetworkingHandler {

    func tryToRunAndRefreshTokenWhenNeeded<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {

        func refreshTokenAndTriggerRequestOneMoreTime() async throws -> (R.Output, HTTPResponse) {
            logger.debug("Refreshing token and trying to run request \(type(of: R.self))")

            do {
                try await loginHandler.refreshToken()
            } catch {
                logger.error("Unable to refresh token with error: \(error.localizedDescription)")
                logger.info("Re login user to get the new token and refresh token")

                throw NetworkingHandlerError.unableToRefreshToken(underlyingError: error)
            }

            return try await apiClient.run(request)
        }

        do {
            return try await apiClient.run(request)
        } 
        // Catch error related expired JWT
        catch OnionError.notSuccessStatus(let response, _) where response.status.code == 401 {
            logger.debug("Unauthorised request \(type(of: R.self))")

            return try await refreshTokenAndTriggerRequestOneMoreTime()

        } catch {
            logger.error("Error running \(type(of: R.self)) with error: \(error.localizedDescription)")
            throw error
        }

    }
}

// MARK: - Mock

final class MockNetworkingHandler: NetworkingHandlerType {

        func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
            fatalError("MockNetworkingHandler.run not implemented")
        }
}
