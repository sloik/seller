// system
import XCTest
@testable import Lettuce
@testable import Onion

final class WriteNewMessageRequestTests: XCTestCase {
    
    func test_parsingInputJsonExample() throws {
        
        // Arrange
        
        // json from: /// https://developer.allegro.pl/documentation#operation/newMessagePOST
        let jsonString =
        """
        {
          "recipient": {
            "login": "string"
          },
          "text": "string",
          "attachments": [
            {
              "id": "string"
            }
          ]
        }
        """
        // Act
        let result = try JSONDecoder().decode(WriteNewMessageRequest.Input.self, from: jsonString.data(using: .utf8)!)
        
        // Assert
        let expectedResult = WriteNewMessageRequest.Body(
            recipient: WriteNewMessageRequest.Body.Recipient(login: "string"),
            text: "string",
            attachments: [Identifier(id: "string")])
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_parsingOutputJsonExample() throws {
        
        // Arrange
        
        // json from: /// https://developer.allegro.pl/documentation#operation/newMessagePOST
        let jsonString =
        """
        {
          "id": "string",
          "status": "VERIFYING",
          "type": "MESSAGE_CENTER",
          "createdAt": "2019-08-24T14:15:22Z",
          "thread": {
            "id": "string"
          },
          "author": {
            "login": "string",
            "isInterlocutor": true
          },
          "text": "string",
          "subject": "string",
          "relatesTo": {
            "offer": {
              "id": "string"
            },
            "order": {
              "id": "string"
            }
          },
          "hasAdditionalAttachments": false,
          "attachments": [
            {
              "fileName": "string",
              "mimeType": "string",
              "url": "string",
              "status": "NEW"
            }
          ],
          "additionalInformation": {
            "vin": "JT2SV12E6F0308977"
          }
        }
        """
        // Act
        let result = try JSONDecoder().decode(WriteNewMessageRequest.Output.self, from: jsonString.data(using: .utf8)!)
        
        // Assert
        let expectedResult = WriteNewMessageRequest.Output(
            id: "string",
            status: .verifying,
            type: .messageCenter,
            createdAt: "2019-08-24T14:15:22Z",
            thread: Identifier(id: "string"),
            author: Author(login: "string", isInterlocutor: true),
            text: "string",
            subject: "string",
            relatesTo: WriteNewMessageRequest.Output.RelatedObject(
                offer: Identifier(id: "string"),
                order: Identifier(id: "string")
            ),
            hasAdditionalAttachments: false,
            attachments: [Attachment(
                fileName: "string",
                mimeType: "string",
                urlString: "string",
                status: .new)],
            additionalInformation: WriteNewMessageRequest.Output.AdditionalInformation(
                vin: "JT2SV12E6F0308977")
        )

        XCTAssertEqual(result, expectedResult)
    }
}
