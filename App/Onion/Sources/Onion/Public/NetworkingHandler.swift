
// System
import Foundation
import OSLog

// Local

// 3rd party
import HTTPTypes
import AliasWonderland

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

public enum NetworkingHandlerError: Error {

    /// Thrown when refresh token request does not provide a valid token.
    case unableToRefreshToken(underlyingError: Error)
}

extension NetworkingHandler: NetworkingHandlerType {

    @discardableResult
    public func run<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {
        try await tryToLoad {
            if request.authorizationWithJWTNeeded {
                var copy = request
                // Override or add auth header with the lates token.
                if loginHandler.hasToken {
                    copy.headerFields[.authorization] = .bearer(loginHandler.token!)
                }
                return try await tryToRunAndRefreshTokenWhenNeeded(copy)
            } else {
                return try await apiClient.run(request)
            }
        }
    }
}

private extension NetworkingHandler {

    /// Runs `action` and in case of errors retries is to total of 3 times.
    func tryToLoad<A,B>(action: AsyncThrowsProducer<A,B>) async throws -> (A, B) {

        // Tries to get the data for a request 2 times
        for _ in 1...2 {
            do {
                return try await action()
            } catch {
                // ignore the error now
                logger.error("\(type(of: self)) \(#function)> Error while trying to load data: \(error)")
                continue
            }
        }

        // try it 3rd and last time
        return try await action()
    }

    func tryToRunAndRefreshTokenWhenNeeded<R: Request>(_ request: R) async throws -> (R.Output, HTTPResponse) {

        func refreshTokenAndTriggerRequestOneMoreTime() async throws -> (R.Output, HTTPResponse) {
            logger.debug("\(type(of: self)) \(#function)> Refreshing token and trying to run request \(type(of: R.self))")

            do {
                try await loginHandler.refreshToken()
                assert(loginHandler.token.isNotNone, "After refresh token should not be empty.")

                // Updates token in the request
                var copy = request
                copy.headerFields[.authorization] = .bearer(loginHandler.token!)

                return try await apiClient.run(copy)
            } catch {
                logger.error("\(type(of: self)) \(#function)> Unable to refresh token with error: \(error.localizedDescription)")
                logger.info("\(type(of: self)) \(#function)> Re login user to get the new token and refresh token")

                throw NetworkingHandlerError.unableToRefreshToken(underlyingError: error)
            }
        }

        do {
            logger.debug("\(type(of: self)) \(#function)> Trying to run request \(type(of: request))")

            if let uploadRequest = request as? any UploadRequest {
                let (content, response) = try await apiClient.upload(uploadRequest)

                return (content as! R.Output, response)
            } else {
                return try await apiClient.run(request)
            }
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
