// system
import XCTest
@testable import Lettuce

final class ResponseMessageInThreadTests: XCTestCase {
    
    func test_parsingJsonExample() throws {
        
        // Arrange
        
        // json from: /// https://developer.allegro.pl/documentation#operation/newMessageInThreadPOST
        let jsonString =
        """
        {
          "text": "string",
          "attachments": [
            {
              "id": "string"
            }
          ]
        }
        """
        // Act
        let result = try JSONDecoder().decode(NewMessageInThread.self, from: jsonString.data(using: .utf8)!)
        
        // Assert
        let expectedResult = NewMessageInThread(
            text: "string",
            attachments: ["string"]
        )

        XCTAssertEqual(result, expectedResult)
    }
}
