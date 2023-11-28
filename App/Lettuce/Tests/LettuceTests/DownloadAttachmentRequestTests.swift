import XCTest
@testable import Lettuce

final class DownloadAttachmentRequestTests: XCTestCase {

    func test() throws {
        // Arrange
        let expectedRelativeUrlPath = "/messaging/message-attachments/123456"
        let request = DownloadAttchmentRequest(attachmentId: "123456", token: "JWTTOKEN")

        // Act
        let urlRelativePath = request.path

        // Assert
        XCTAssertEqual(urlRelativePath, expectedRelativeUrlPath)
    }
}
