

import XCTest

@testable import Onion

final class LoginHandlerTypeTests: XCTestCase {

    var loginHandler: MockLoginHandler!
    var sut: LoginHandlerType { loginHandler }

    override func setUp() async throws {
        try await super.setUp()

        loginHandler = MockLoginHandler()
    }

    override func tearDown() async throws {
        loginHandler = .none
        try await super.tearDown()
    }


    func test_hasToken_whenTokenIsPresent_shouldReturnTrue() {
        // Arrange
        loginHandler.tokenProducer = { "TOKEN" }

        // Act
        let hasToken = loginHandler.hasToken

        // Assert
        XCTAssertTrue(hasToken)
    }

    func test_hasToken_whenTokenIsNotPresent_shouldReturnFalse() {
        // Arrange
        loginHandler.tokenProducer = .none

        // Act
        let hasToken = loginHandler.hasToken

        // Assert
        XCTAssertFalse(hasToken)
    }
}

