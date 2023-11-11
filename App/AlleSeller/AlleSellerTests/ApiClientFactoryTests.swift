
import XCTest
@testable import AlleSeller

import InlineSnapshotTesting
import Onion

final class ApiClientFactoryTests: XCTestCase {

    func test_environment_name() throws {
        // Arrange
        let sut: [ApiClientFactory.Environment] = [
            .production,
            .sandbox,
            .custom(URL(string: "https://example.com")!)
        ]

        // Act
        assertInlineSnapshot(
            of: sut.map(\.name).joined(separator:"\n"),
            as: .lines
        ) {
        """
        Production
        Sandbox
        Custom
        """
        }
    }

    func test_environment_url() throws {
        // Arrange
        let sut: [ApiClientFactory.Environment] = [
            .production,
            .sandbox,
            .custom(URL(string: "https://example.com")!)
        ]

        // Act
        assertInlineSnapshot(
            of: sut.map(\.url.absoluteString).joined(separator:"\n"),
            as: .lines
        ) {
        """
        https://allegro.pl
        https://allegro.pl.allegrosandbox.pl
        https://example.com
        """
        }
    }

    func test_environment_isCustom() throws {
        // Arrange
        let sut: [ApiClientFactory.Environment] = [
            .production,
            .sandbox,
            .custom(URL(string: "https://example.com")!)
        ]

        let expectedValues: [Bool] = [
            false,
            false,
            true
        ]

        // Act
        let actualValues = sut.map( \.isCustom )

        // Assert
        XCTAssertEqual(actualValues, expectedValues)
    }

    func test_environment_description() throws {
        // Arrange
        let sut: [ApiClientFactory.Environment] = [
            .production,
            .sandbox,
            .custom(URL(string: "https://example.com")!)
        ]

        // Act
        assertInlineSnapshot(
            of: sut.map(\.description).joined(separator:"\n"),
            as: .lines
        ) {
        """
        Production
        Sandbox
        Custom: https://example.com
        """
        }
    }

    func test_makeApiClient() throws {
        // Arrange
        let sut: [ApiClientFactory.Environment] = [
            .production,
            .sandbox,
            .custom(URL(string: "https://example.com")!)
        ]

        let expectedClientURLs = [
            URL(string: "https://allegro.pl")!,
            URL(string: "https://allegro.pl.allegrosandbox.pl")!,
            URL(string: "https://example.com")!
        ]

        // Act
        let actualValues = sut.map( ApiClientFactory.makeApiClient )

        // Assert
        XCTAssertEqual(actualValues.map(\.baseURL), expectedClientURLs)
    }

}
