import XCTest

import HTTPTypes

@testable import Onion

final class OnionTests: XCTestCase {

    func test_authorizationWithJWTNeeded() throws {

        let just = TestsFlow.okResponse.request
        XCTAssertFalse( just.authorizationWithJWTNeeded )

        let auth = TestsFlow.unauthorizedResponse.request
        XCTAssertTrue( auth.authorizationWithJWTNeeded )
    }
}

