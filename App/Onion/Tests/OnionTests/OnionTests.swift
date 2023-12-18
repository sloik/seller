import XCTest

import HTTPTypes

@testable import Onion

final class OnionTests: XCTestCase {

    func test_authorizationWithJWTNeeded() throws {

        let just = TestsFlow.okResponse
        XCTAssertFalse( just.authorizationWithJWTNeeded )

        let auth = TestsFlow.unauthorizedResponse
        XCTAssertTrue( auth.authorizationWithJWTNeeded )
    }
}

