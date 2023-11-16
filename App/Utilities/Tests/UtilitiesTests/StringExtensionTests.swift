import XCTest
@testable import Utilities

final class StringExtensionTests: XCTestCase {


    func test_base64UrlDecode() {

        // Arrange
        let sut = "eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ"

        // Act
        let result = sut.base64UrlDecode

        // Assert
        XCTAssertEqual(
            result,
            Data("{\"sub\":\"1234567890\",\"name\":\"John Doe\",\"iat\":1516239022}".utf8)
        )
    }

}
