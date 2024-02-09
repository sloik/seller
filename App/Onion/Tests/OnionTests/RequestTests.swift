import XCTest

import HTTPTypes

@testable import Onion

final class RequestTests: XCTestCase {

    func test_defaultHeaders_shouldBeEmpty() {
        XCTAssertEqual(
            Req().headerFields,
            [:],
            "Expected to have empty header fields."
        )
    }

    func test_defaultMethod_shouldBeGET() {
        XCTAssertEqual(
            Req().method,
            .get,
            "Default HTTP method should be GET!"
        )
    }
}


fileprivate struct Req: Request {
    typealias Output = String
    var path: String = "/path"
    var headerFields: HTTPFields = [:]
}
