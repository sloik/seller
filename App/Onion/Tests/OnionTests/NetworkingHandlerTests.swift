import XCTest

import Onion
import HTTPTypes

import ExTests

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

    func test_shouldUseApiClientToRunRequests() async throws {

        // Arrange
        let request = NetworkFlow.okResponse

        // Act
        let (response, httpResponse) = try await sut.run(request)

        // Assert
        XCTAssertEqual(response, .mock)
        XCTAssertEqual(httpResponse.status, .ok)

        XCTAssertEqual(
            apiClient.processedRequests.map(\.tag),
            ["Ok Request"]
        )
    }

    func test_run_whenSessionFails_shouldTryRequestMaxThreeTimes() async throws {
        // Arrange

        let expectedError = "Some error in running the request!"
        let dataRequestExpectation = expectation(description: "Should call dataForRequest three times").expect(3).strict()

        let request = NetworkFlow.throwingResponse
        request.responseProducer = {
            dataRequestExpectation.fulfill()
            throw expectedError
        }

        // Act & Assert
        do {
            try await sut.run( request )
            XCTFail("Should throw")
        } catch let error as String {
            XCTAssertEqual(error, expectedError)

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }

    }

//    func test_tryToRunAndRefreshTokenWhenNeeded() async throws {
//
//        let apiClient = MockAPIClient()
//        let loginHandler = MockLoginHandler()
//
//        let networkingHandler = NetworkingHandler(
//            apiClient: apiClient,
//            loginHandler: loginHandler
//        )
//
//        let request = JustRequest()
//        let (output, response) = try await networkingHandler.run(request)
//
//        XCTAssertEqual(output, "MockRequest")
//        XCTAssertEqual(response.statusCode, 200)
//    }
//
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
