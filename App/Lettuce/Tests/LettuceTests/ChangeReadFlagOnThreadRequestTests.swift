
import Foundation
import XCTest

@testable import Lettuce

final class ChangeReadFlagOnThreadRequestTests: XCTestCase {

    func test_shouldParseResponse() {

        // Arrange
        let jsonString =
        """
        {
          "id": "string",
          "read": true,
          "lastMessageDateTime": "2019-08-24T14:15:22Z",
          "interlocutor": {
            "login": "string",
            "avatarUrl": "string"
          }
        }
        """

        let expectedResult = ChangeReadFlagOnThreadRequest.Response(
            id: "string",
            read: true,
            lastMessageDateTime: "2019-08-24T14:15:22Z",
            interlocutor: Interlocutor(
                login: "string",
                avatarUrl: "string"
            )
        )

        // Act
        let result = try! JSONDecoder().decode(ChangeReadFlagOnThreadRequest.Response.self, from: jsonString.data(using: .utf8)!)

        // Assert
        XCTAssertEqual(result, expectedResult)
    }
}
