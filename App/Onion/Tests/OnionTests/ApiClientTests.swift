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
            try await sut.run(TestsFlow.okResponse.request)
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

            return try TestsFlow.okResponse.responseData
        }

        // Act & Assert
        do {
            try await sut.run(TestsFlow.okResponse.request)

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }

    func test_upload_shouldRunOnlyOnceFor200Ok() async throws {
        // Arrange
        let dataRequestExpectation = expectation(description: "Should call uploadForRequest only once").onceStrict()

        await session.setUploadFor { _,_ in
            dataRequestExpectation.fulfill()

            let flow = TestsFlow.okResponse
            return try flow.responseData
        }

        // Act & Assert
        do {
            _ = try await sut.upload( TestsFlow.okResponse.request )

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
}

