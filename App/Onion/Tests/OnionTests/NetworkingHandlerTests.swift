import XCTest

import Onion
import HTTPTypes

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
        let request = MockRequest.okResponse

        // Act
        let (response, httpResponse) = try await sut.run(request)

        // Assert
        XCTAssertEqual(response, "Mock Response")
        XCTAssertEqual(httpResponse.status, .ok)

        XCTAssertEqual(
            apiClient.processedRequests.map(\.tag),
            ["Ok Request"]
        )
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
