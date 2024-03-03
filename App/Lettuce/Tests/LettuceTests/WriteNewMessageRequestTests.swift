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
               "offer": {
                              "id": "15030554210",
                              "thumbnailUrl": "https://a.allegroimg.com/original/1193cf/1d2157e44c0291c32f4366510d7f",
                              "name": "[test] Zuczek - international",
                              "url": "https://allegro.pl/oferta/15030554210",
                              "marketplaceBasePrices": {
                                  "marketplace": "allegro-pl",
                                  "amount": 3.5,
                                  "currency": "PLN"
                              }
                          },
          "relatesTo": {
            "offer": {
                              "id": "15030554210",
                              "thumbnailUrl": "https://a.allegroimg.com/original/1193cf/1d2157e44c0291c32f4366510d7f",
                              "name": "[test] Zuczek - international",
                              "url": "https://allegro.pl/oferta/15030554210",
                              "marketplaceBasePrices": {
                                  "marketplace": "allegro-pl",
                                  "amount": 3.5,
                                  "currency": "PLN"
                              }
                          },
            "order": {
              "id": "string"
            }
          },
          "hasAdditionalAttachments": false,
          "attachments": [
            {
              "fileName": "
              "mimeType": "image/jpeg",,
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
            offer: Offer(
                id:"15030554210",
                         thumbnailUrl: "https://a.allegroimg.com/original/1193cf/1d2157e44c0291c32f4366510d7f",
                         name: "[test] Zuczek - international",
                         url: "https://allegro.pl/oferta/15030554210"),
            relatesTo: WriteNewMessageRequest.Output.RelatedObject(
                offer: Offer(
                    id: "15030554210",
                    thumbnailUrl: "https://a.allegroimg.com/original/1193cf/1d2157e44c0291c32f4366510d7f",
                    name: "[test] Zuczek - international",
                    url: "https://allegro.pl/oferta/15030554210"
                ),
                order: Identifier(id: "string")
            ),
            hasAdditionalAttachments: false,
            attachments: [Attachment(
                fileName: "string",
                mimeType: Attachment.MimeType.imageJpeg,
                urlString: "string",
                status: .new)],
            additionalInformation: WriteNewMessageRequest.Output.AdditionalInformation(
                vin: "JT2SV12E6F0308977")
        )

        XCTAssertEqual(result, expectedResult)
    }
}
