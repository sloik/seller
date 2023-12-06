
import XCTest
@testable import AlleSeller

import InlineSnapshotTesting
import Onion

final class ApiClientFactoryTests: XCTestCase {

    func test_environment_description() throws {
        // Arrange
        let sut: [AppEnvironment] = [
            .production,
            .sandbox,
        ]

        // Act
        assertInlineSnapshot(
            of: sut.map(\.description).joined(separator:"\n"),
            as: .lines
        ) {
        """
        Production
        Sandbox
        """
        }
    }

    func test_makeAuthApiClient() throws {
        // Arrange
        let sut: [AppEnvironment] = [
            .production,
            .sandbox,
        ]

        let expectedClientURLs = [
            URL(string: "https://allegro.pl")!,
            URL(string: "https://allegro.pl.allegrosandbox.pl")!,
        ]

        // Act
        let actualValues = sut.map( ApiClientFactory.makeAuthApiClient(for:) )

        // Assert
        XCTAssertEqual(actualValues.map(\.baseURL), expectedClientURLs)
    }

    func test_makeRestApiClient() throws {
        // Arrange
        let sut: [AppEnvironment] = [
            .production,
            .sandbox,
        ]

        let expectedClientURLs = [
            URL(string: "https://api.allegro.pl")!,
            URL(string: "https://api.allegro.pl.allegrosandbox.pl")!,
        ]

        // Act
        let actualValues = sut.map( ApiClientFactory.makeRestApiClient(for:) )

        // Assert
        XCTAssertEqual(actualValues.map(\.baseURL), expectedClientURLs)
    }

}
