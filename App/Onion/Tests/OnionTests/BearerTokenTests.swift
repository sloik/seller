
import XCTest

import HTTPTypes

@testable import Onion

final class BearerTokenTests: XCTestCase {

    func test_inits() {
        let _: BearerToken = .init(token: "TOKEN")
        let _: BearerToken = "TOKEN"
    }

    func test_tokenProperty_shouldReturnPassedInTokenProvidedDurringCreation() {

        // Arrange
        let expectedToken = "TOKEN"
        let sut = BearerToken(token: expectedToken)

        // Act
        let token = sut.token

        // Assert
        XCTAssertEqual(token, expectedToken)
    }

    func test_headerFiled_shouldContainAuthorization() {
        // Arrange
        let token = "TOKEN"
        let sut = BearerToken(token: token)

        // Act
        let field = sut.httpField

        // Assert
        XCTAssertEqual(
            field,
            HTTPField(
                name: .authorization,
                value: .bearer(token)
            )
        )
    }
}
