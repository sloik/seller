
import XCTest

import Onion

final class IdentifierTests: XCTestCase {

    func test_inits() {
        let _ = Identifier<String>(id: "TAG")
        let _:Identifier<String> = "TAG"
    }

    func test_id_shouldReturnInitialValue() {

        // Arrange
        let expectedId = "TAG"

        // Act
        let sut = Identifier<String>(id: expectedId)

        // Assert
        XCTAssertEqual(sut.id, expectedId)

    }
}
