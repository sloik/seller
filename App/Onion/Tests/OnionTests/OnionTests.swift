import XCTest

import HTTPTypes

@testable import Onion

final class OnionTests: XCTestCase {

    func test_authorizationWithJWTNeeded() throws {

        let just = Flow.okResponse
        XCTAssertFalse( just.authorizationWithJWTNeeded )

        let auth = Flow.unauthorizedResponse
        XCTAssertTrue( auth.authorizationWithJWTNeeded )
    }
}

