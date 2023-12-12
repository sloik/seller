import XCTest

import HTTPTypes

@testable import Onion

final class OnionTests: XCTestCase {

    func test_authorizationWithJWTNeeded() throws {

        let just = JustRequest()
        XCTAssertFalse( just.authorizationWithJWTNeeded )

        let auth = AuthorizationRequest()
        XCTAssertTrue( auth.authorizationWithJWTNeeded )
    }
}

