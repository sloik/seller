
import XCTest
import HTTPTypes

@testable import Onion
import InlineSnapshotTesting

final class StringHeaderTests: XCTestCase {


    func test_headerFieldsConstants() {

        let constants: String = [String](
            arrayLiteral: .applicationVndAllegroV1Json,
            .applicationJson,
            .applicationPdf,
            .imagePng,
            .imageJpeg,
            .imageGif,
            .imageTiff,
            .imageBmp,
            .bearer("TOKEN"),
            .basic("CREDENTIALS")
        )
            .map { $0 }
            .joined(separator: "\n")

        assertInlineSnapshot(of: constants, as: .description) {
            """
            application/vnd.allegro.public.v1+json
            application/json
            application/pdf
            image/png
            image/jpeg
            image/gif
            image/tiff
            image/bmp
            Bearer TOKEN
            Basic CREDENTIALS
            """
        }

    }

}
