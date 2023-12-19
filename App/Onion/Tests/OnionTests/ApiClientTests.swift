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

    /// When `URLSession` does throw an error.
    ///
    /// ## **Expected behaviour:**
    ///
    /// Error should be passed up without any changes.
    func test_run_shouldThrowAnErrorWhenSessionFails() async throws {
        // Arrange
        let expectedError = "Session failure!"
        await session.setDataFor { _ in
            throw expectedError
        }

        // Act & Assert
        do {
            try await sut.run(Flow.okResponse.request)
            XCTFail("Should throw an error!")
        } catch let error as String {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Thrown unexpected error: \(error)")
        }
    }

    /// When `URLSession` returns a valid response and data
    /// but the response in not from 2xx range.
    ///
    /// ## **Expected behaviour:**
    ///
    /// `OnionError.notSuccessStatus` should be thrown containing original
    /// `HTTPResponse` and data.
    func test_run_shouldThrowAnErrorWhenSessionDoesNotReturn200Ok() async throws {
        // Arrange
        let responsePayload = "Some response"
        var expectedData: Data { Data(responsePayload.utf8) }

        await session.setDataFor { _ in
            (expectedData, HTTPResponse(status: .unauthorized))
        }

        // Act & Assert
        do {
            try await sut.run(Flow.okResponse.request)
            XCTFail("Should not throw an error!")
        } catch OnionError.notSuccessStatus(let response, let data) {
            XCTAssertEqual(response, .init(status: .unauthorized))
            XCTAssertEqual(String(data: data, encoding: .utf8)!, responsePayload)
        } catch {
            XCTFail("Thrown unexpected error: \(error)")
        }
    }

    /// When running a `Request`.
    ///
    /// ## **Expected behaviour:**
    ///
    /// - One run should trigger only one session call.
    /// - Successful request should not throw
    func test_run_shouldRunOnlyOnceFor200Ok() async throws {
        // Arrange
        let dataRequestExpectation = expectation(description: "Should call dataForRequest only once").onceStrict()

        await session.setDataFor { _ in
            dataRequestExpectation.fulfill()

            return try Flow.okResponse.responseData
        }

        // Act & Assert
        do {
            try await sut.run(Flow.okResponse.request)

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }

    /// When running an `UploadRequest` request.
    ///
    /// ## **Expected behaviour:**
    ///
    /// - One upload should trigger only one session call.
    /// - Successful request should not throw
    func test_upload_shouldRunOnlyOnceFor200Ok() async throws {
        // Arrange
        let dataRequestExpectation = expectation(description: "Should call uploadForRequest only once").onceStrict()

        await session.setUploadFor { _,_ in
            dataRequestExpectation.fulfill()

            let flow = Flow.okResponse
            return try flow.responseData
        }

        // Act & Assert
        do {
            _ = try await sut.upload( Flow.okResponse.request )

            await fulfillment(of: [dataRequestExpectation], timeout: 0.1)
        } catch {
            XCTFail("Should not throw error: \(error)")
        }
    }
}

