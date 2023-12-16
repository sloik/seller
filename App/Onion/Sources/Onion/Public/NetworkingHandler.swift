
// System
import Foundation
import OSLog

// Local

// 3rd party
import HTTPTypes

private let logger = Logger(subsystem: "Onion", category: "NetworkingHandler")

public final class NetworkingHandler {

    let apiClient: APIClientType

    let loginHandler: LoginHandlerType

    public init(
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

    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
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
            logger.debug("\(type(of: self)) \(#function)> Refreshing token and trying to run request \(type(of: R.self))")

            do {
                try await loginHandler.refreshToken()
            } catch {
                logger.error("\(type(of: self)) \(#function)> Unable to refresh token with error: \(error.localizedDescription)")
                logger.info("\(type(of: self)) \(#function)> Re login user to get the new token and refresh token")

                throw NetworkingHandlerError.unableToRefreshToken(underlyingError: error)
            }

            return try await apiClient.run(request)
        }

        do {
            logger.debug("\(type(of: self)) \(#function)> Trying to run request \(type(of: request))")
            return try await apiClient.run(request)
        } 
        // Catch error related expired JWT
        catch OnionError.notSuccessStatus(let response, _) where response.status.code == 401 {
            logger.debug("\(type(of: self)) \(#function)> Unauthorised request \(type(of: request))")

            return try await refreshTokenAndTriggerRequestOneMoreTime()

        } catch {
            logger.error("Error running \(type(of: request)) with error: \(error.localizedDescription)")
            throw error
        }

    }
}
