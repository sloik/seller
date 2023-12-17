import XCTest
@testable import KeychainWrapper

final class KeychainWrapperTests: XCTestCase {
    
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

    func test_subscript_get_ShouldRetrieveSavedData() throws {
        //Given
        let sut = KeychainWrapper()
        let data = "some message".data(using: .utf8)!
        let key = "test"

        //When
        sut.set(data, key: key)
        let sub = sut[key]

        //Then
        XCTAssertEqual("some message", String(data:sub!, encoding: .utf8 ))
    }

    func test_subscript_set_ShouldStoreValue() throws {
        //Given
        let sut = KeychainWrapper()
        let data = "some other message".data(using: .utf8)!
        let key = "test1"

        //When
        sut.set(data, key: key)
        sut[key] = "rabbit".data(using: .utf8)!

        //Then
        let sub = sut[key]
        XCTAssertEqual("rabbit", String(data: sub!, encoding: .utf8 ))
    }


    func test_subscript_detlete_ShouldDeleteData() throws {
        //Given
        let sut = KeychainWrapper()
        let data = "pink noise".data(using: .utf8)!
        let key = "test2"

        //When
        sut.set(data, key: key)
        let storedData = sut[key]
        XCTAssertEqual("pink noise", String(data: storedData!, encoding: .utf8 ))

        sut[key] = nil

        //Then
        let dataAfterDelete = sut[key]
        XCTAssertNil(dataAfterDelete)
    }

}
