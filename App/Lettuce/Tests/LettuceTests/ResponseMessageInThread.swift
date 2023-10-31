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
        let result = try JSONDecoder().decode(MessageInThread.self, from: jsonString.data(using: .utf8)!)
        
        // Assert
        let expectedResult = MessageInThread(
            text: "string",
            attachments: [MessageInThread.AttachmentId(id: "string")])
        
        XCTAssertEqual(result, expectedResult)
    }
}
