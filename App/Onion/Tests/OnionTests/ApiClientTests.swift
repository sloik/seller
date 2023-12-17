import XCTest

import Onion
import HTTPTypes
import ExTests

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
        await session.setDataFor { _ in
            (Data(), HTTPResponse(status: .unauthorized))
        }

        // Act & Assert
        do {
            try await sut.run(JustRequest())
            XCTFail("Should throw an error!")
        } catch OnionError.notSuccessStatus(let response, _) {
            XCTAssertEqual(response, .init(status: .unauthorized))
        } catch {
            XCTFail("Thrown unexpected error: \(error)")
        }
    }

    func test_run_shouldRunOnlyOnceFor200Ok() async throws {
        // Arrange
        let dataRequestExpectation = expectation(description: "Should call dataForRequest only once").onceStrict()

        await session.setDataFor { _ in
            dataRequestExpectation.fulfill()

            let response: MockResponse? = .mock
            return (response.encode()!, HTTPResponse(status: .ok))
        }

        // Act & Assert
        do {
            try await sut.run(JustRequest())

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }

    func test_run_whenSessionFails_shouldTryRequestMaxThreeTimes() async throws {
        // Arrange
        let dataRequestExpectation = expectation(description: "Should call dataForRequest three times").expect(3).strict()

        await session.setDataFor { _ in
            dataRequestExpectation.fulfill()
            throw "URLSession error"
        }

        // Act & Assert
        do {
            try await sut.run(JustRequest())
            XCTFail("Should throw")
        } catch let error as String {
            XCTAssertEqual(error, "URLSession error")

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Unexpected error thrhown: \(error)")
        }

    }

}

