// system
import XCTest
@testable import Lettuce

final class ResponseMessageTests: XCTestCase {
    
    func test_parsingJsonExample() throws {
        
        // Arrange
        
        // json from: https://developer.allegro.pl/documentation#operation/getMessageGET
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
        let result = try JSONDecoder().decode(Message.self, from: jsonString.data(using: .utf8)!)
        
        // Assert
        let expectedResult = Message(
            id: "string",
            status: Message.Status.verifying,
            type: Message.MessageType.messageCenter,
            createdAt: "2019-08-24T14:15:22Z",
            thread: Message.ThreadId(id: "string"),
            author: Author(
                login: "string",
                isInterlocutor: true
            ),
            text: "string",
            subject: "string",
            relatesTo: Message.RelatedObject(
                offer: Message.ThreadId(id: "string"),
                order: Message.ThreadId(id: "string")),
            hasAdditionalAttachments: false,
            attachments: [Attachment(
                fileName: "string",
                mimeType: "string",
                url: "string",
                status: Attachment.Status.new)],
            additionalInformation: Message.AdditionalInformation(
                vin: "JT2SV12E6F0308977"))
        
        XCTAssertEqual(result, expectedResult)
    }
}
