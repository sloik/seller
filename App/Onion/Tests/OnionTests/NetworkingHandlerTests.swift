import XCTest

import Onion
import HTTPTypes

import ExTests
import AliasWonderland

final class NetworkingHandlerTests: XCTestCase {

    var apiClient: MockApiClient!
    var loginHandler: MockLoginHandler!
    var sut: NetworkingHandler!


    override func setUp() async throws {
        try await super.setUp()

        apiClient = MockApiClient()
        loginHandler = MockLoginHandler()

        sut = NetworkingHandler(apiClient: apiClient, loginHandler: loginHandler)
    }

    override func tearDown() async throws {
        sut = .none
        loginHandler = .none
        apiClient = .none

        try await super.tearDown()
    }

    /// When running a `Request`
    ///
    /// ## **Expected behaviour:**
    ///
    /// - `APIClient` should be used to run the request.
    /// - Data should be returned
    /// - `HTTPStatus` should be returned
    func test_shouldUseApiClientToRunRequests() async throws {

        // Arrange
        let flow = TestsFlow.okResponse

        // Act
        do {
            let (response, httpResponse) = try await sut.run(flow)

            // Assert
            XCTAssertEqual(response, .mock)
            XCTAssertEqual(httpResponse.status, .ok)

            XCTAssertEqual(
                apiClient.processedRequests.map(\.tag),
                ["Ok Request"]
            )
        } catch {
            XCTFail("Should not throw!")
        }
    }

    /// When running a `Request` and it fails
    ///
    /// ## **Expected behaviour:**
    ///
    /// - request should be retried 3x
    /// - result of final error should be returned
    func test_run_whenSessionFails_shouldTryRequestMaxThreeTimes() async throws {
        // Arrange

        let expectedError = "Some error in running the request!"
        let dataRequestExpectation = expectation(description: "Should call dataForRequest 3 times").expect(3).strict()

        let flow = TestsFlow.throwingResponse

        flow.responseProducer = {
            dataRequestExpectation.fulfill()
            throw expectedError
        }

        // Act & Assert
        do {
            try await sut.run( flow )
            XCTFail("Should not throw")
        } catch let error as String {
            XCTAssertEqual(error, expectedError)

            XCTAssertEqual(
                apiClient.processedRequests.map(\.tag),
                ["Throwing Request", "Throwing Request", "Throwing Request"]
            )

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }

    }

    func test_tryToRunAndRefreshTokenWhenNeededAndRetryTheRequest() async throws {
        // Arrange
        let didRefreshToken = expectation(description: "Did not refresh token!").onceStrict()
        let didRetryTheRequest = expectation(description: "Should retry the request!").onceStrict()

        let fulfillRetryRequestAndReturnOkResponse: ThrowsProducer<(FlowResponse, HTTPResponse)> = {
            didRetryTheRequest.fulfill()
            return try TestsFlow.okResponse.response
        }

        // Start with a flow that need a token and throws an unauthorized response error.
        let flow = TestsFlow.unauthorizedResponse
        flow.responseProducer = {
            throw OnionError.notSuccessStatus(response: .init(status: .unauthorized), data: Data())
        }

        // Check that token was refreshed
        loginHandler.refreshTokenClosure = { _ in
            didRefreshToken.fulfill()
            flow.responseProducer = fulfillRetryRequestAndReturnOkResponse
        }

        // Act
        do {
            let (output, response) = try await sut.run(flow)

            await fulfillment(
                of: [
                    didRefreshToken,
                    didRetryTheRequest
                ],
                timeout: 0.1,
                enforceOrder: true
            )

            XCTAssertEqual(output, .mock)
            XCTAssertEqual(response, .init(status: .ok))
        } catch {
            XCTFail("No erros should be thrown!")
        }
    }

//    func test_tryToRunAndRefreshTokenWhenNeeded_whenRefreshTokenThrows() async throws {
//
//        let apiClient = MockAPIClient()
//        let loginHandler = MockLoginHandler(shouldThrow: true)
//
//        let networkingHandler = NetworkingHandler(
//            apiClient: apiClient,
//            loginHandler: loginHandler
//        )
//
//        let request = MockRequest()
//        do {
//            _ = try await networkingHandler.run(request)
//            XCTFail("Should have thrown")
//        } catch {
//            XCTAssertEqual(error.localizedDescription, "MockLoginHandler.refreshToken throws")
//        }
//    }
}
