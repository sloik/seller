// system
import XCTest
@testable import Lettuce

final class ResponseListUserThreadsTests: XCTestCase {
    
    func test_requestWithNilDefaultParameters() throws {
        // Arrange
        let expectedRelativeUrlPath = "/messaging/threads?limit=20&offset=0"
        let request = GetListUserThreads(token: "token")
        
        // Act
        let urlRelativePath = request.preparePathWithComponents()
        
        // Assert
        XCTAssert(urlRelativePath == expectedRelativeUrlPath)
    }
    
    func test_requestWithAllParameters() throws {
        // Arrange
        let expectedRelativeUrlPath = "/messaging/threads?limit=30&offset=4"
        let request = GetListUserThreads(token: "token", limit: 30, offset: 4)
        
        // Act
        let urlRelativePath = request.preparePathWithComponents()
        
        // Assert
        XCTAssert(urlRelativePath == expectedRelativeUrlPath)
    }
    
    func test_parsingJsonExample() throws {
        
        // Arrange
        
        // json from: https://developer.allegro.pl/documentation#operation/listThreadsGET
        let jsonString =
        """
        {
          "threads": [
            {
              "id": "string",
              "read": true,
              "lastMessageDateTime": "2019-08-24T14:15:22Z",
              "interlocutor": {
                "login": "string",
                "avatarUrl": "string"
              }
            }
          ],
          "offset": 0,
          "limit": 0
        }
        """
        // Act
        let result = try JSONDecoder().decode(ListUserThreads.self, from: jsonString.data(using: .utf8)!)
        
        // Assert
        let expectedResult = ListUserThreads(
            threads: [
                MessageCenterThread(
                    id: "string",
                    read: true,
                    lastMessageDateTime: "2019-08-24T14:15:22Z",
                    interlocutor: Interlocutor(
                        login: "string",
                        avatarUrlString: "string")
                )
            ],
            offset: 0,
            limit: 0)
        
        XCTAssertEqual(result, expectedResult)
    }
}
