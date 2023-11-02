// system
import XCTest
@testable import Lettuce

final class ResponseListMessagesInThreadTests: XCTestCase {
    
    func test_requestWithNilDefaultParameters() throws {
        // Arrange
        let expectedRelativeUrlPath = "/messaging/threads/11/messages?limit=20&offset=0"
        let request = ListMessagesInThreadRequest(token: "token", threadId: "11", before: nil, after: nil)
        
        // Act
        let urlRelativePath = request.preparePathWithComponents()
        
        // Assert
        XCTAssert(urlRelativePath == expectedRelativeUrlPath)
    }
    
    func test_requestWithBeforeAndDefaultParameters() throws {
        // Arrange
        let expectedRelativeUrlPath = "/messaging/threads/11/messages?limit=20&offset=0&before=before"
        let request = ListMessagesInThreadRequest(token: "token", threadId: "11", before: "before", after: nil)
        
        // Act
        let urlRelativePath = request.preparePathWithComponents()
        
        // Assert
        XCTAssert(urlRelativePath == expectedRelativeUrlPath)
    }
    
    func test_requestWithAllParameters() throws {
        // Arrange
        let expectedRelativeUrlPath = "/messaging/threads/11/messages?limit=30&offset=5&before=before&after=after"
        let request = ListMessagesInThreadRequest(token: "token", threadId: "11", limit: 30, offset: 5, before: "before", after: "after")
        
        // Act
        let urlRelativePath = request.preparePathWithComponents()
        
        // Assert
        XCTAssert(urlRelativePath == expectedRelativeUrlPath)
    }
    
    func test_parsingJsonExample() throws {
        
        // Arrange
        
        // json from: https://developer.allegro.pl/documentation#operation/listMessagesGET
        let jsonString =
        """
        {
          "messages": [
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
          ],
          "offset": 0,
          "limit": 0
        }
        """
        // Act
        let result = try JSONDecoder().decode(MessageInThread.self, from: jsonString.data(using: .utf8)!)
        
        // Assert
        let expectedResult = MessageInThread(
            messages: [Message(
                id: "string",
                status: Message.Status.verifying,
                type: Message.MessageType.messageCenter,
                createdAt: "2019-08-24T14:15:22Z",
                thread: Message.ThreadId(
                    id: "string"),
                author: Message.Author(
                    login: "string",
                    isInterlocutor: true),
                text: "string",
                subject: "string",
                relatesTo: Message.RelatedObject(
                    offer: Message.ThreadId(id: "string"),
                    order: Message.ThreadId(id: "string")),
                hasAdditionalAttachments: false,
                attachments: [Message.AttachmentInfo(
                    fileName: "string",
                    mimeType: "string",
                    url: "string",
                    status: Message.AttachmentInfo.Status.new)],
                additionalInformation: Message.AdditionalInformation(vin: "JT2SV12E6F0308977"))],
            offset: 0,
            limit: 0)
        
        XCTAssertEqual(result, expectedResult)
    }
}
