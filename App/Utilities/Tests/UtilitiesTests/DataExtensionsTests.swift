
import XCTest
import Utilities

import InlineSnapshotTesting

final class DataExtensionsTests: XCTestCase {

    func test_toDictionary() throws {

        // Arrange
        let sut = Data("{\"sub\":\"1234567890\",\"name\":\"John Doe\",\"iat\":1516239022}".utf8)

        // Act
        let result = try sut.toDictionary

        // Assert

        assertInlineSnapshot(of: result, as: .json) {
            """
            {
              "iat" : 1516239022,
              "name" : "John Doe",
              "sub" : "1234567890"
            }
            """
        }
    }

}
