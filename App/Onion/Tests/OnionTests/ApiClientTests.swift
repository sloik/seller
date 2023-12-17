import XCTest

import Onion
import HTTPTypes

final class ApiClientTests: XCTestCase {

    var session: MockURLSession!
    var sut: APIClient!

    override func setUp() async throws {
        try await super.setUp()

        session = MockURLSession()

        sut = APIClient(
            baseURL: URL(string: "https://fake.api.pl")!,
            session: session
        )
    }

    override func tearDown() async throws {
        sut = .none
        session = .none
        try await super.tearDown()
    }

    func test_run_shouldThrowAnErrorWhenSessionDoesNotReturn200Ok() async throws {
        // Arrange
        session.dataForRequestClosure = { _ in
            (Data(), HTTPResponse(status: .unauthorized))
        }

        // Act & Assert
        do {
            try await sut.run(JustRequest())
            XCTFail("Should throw an error!")
        } catch OnionError.notSuccessStatus(let response, let data) {
            XCTAssertEqual(response, .init(status: .unauthorized))
        } catch {
            XCTFail("Thrown unexpected error: \(error)")
        }


    }

}

