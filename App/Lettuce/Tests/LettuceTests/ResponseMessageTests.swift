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
                    "id": "12345",
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
                            "fileName": "string",
                            "mimeType": "image/jpeg",
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
            id: "12345",
            status: Message.Status.verifying,
            type: Message.MessageType.messageCenter,
            createdAt: "2019-08-24T14:15:22Z",
            thread: "string",
            author: Author(
                login: "string",
                isInterlocutor: true
            ),
            text: "string",
            subject: "string",
            offer: Offer(
                id:"15030554210",
                         thumbnailUrl: "https://a.allegroimg.com/original/1193cf/1d2157e44c0291c32f4366510d7f",
                         name: "[test] Zuczek - international",
                         url: "https://allegro.pl/oferta/15030554210"),
            relatesTo: Message.RelatedObject(
                offer: Offer(
                    id: "15030554210",
                    thumbnailUrl: "https://a.allegroimg.com/original/1193cf/1d2157e44c0291c32f4366510d7f",
                    name: "[test] Zuczek - international",
                    url: "https://allegro.pl/oferta/15030554210"
                ),
                order: "string"
            ),
            hasAdditionalAttachments: false,
            attachments: [Attachment(
                fileName: "string",
                mimeType: Attachment.MimeType.imageJpeg,
                urlString: "string",
                status: Attachment.Status.new)],
            additionalInformation: Message.AdditionalInformation(
                vin: "JT2SV12E6F0308977"))
        
        XCTAssertEqual(result, expectedResult)
    }
}
