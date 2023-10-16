//
//  KeychainWrapperDemoTests.swift
//  KeychainWrapperDemoTests
//
//  Created by Edward Maliniak on 26/09/2023.
//

import XCTest
@testable import KeychainWrapperDemo
@testable import KeychainWrapper

final class KeychainWrapperDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_shouldRetrieveSavedData() throws {
        let sut = KeychainWrapper()

        let data = "some message".data(using: .utf8)!

        XCTAssertTrue(
            sut.set(data, key: "key"),
            "Should add value for key!"
        )

        let result =  try XCTUnwrap( sut.data(for: "key") )

        XCTAssertEqual(
            String(data: result, encoding: .utf8),
            "some message"
        )
    }

}
