
import Foundation

public extension String {

    static var applicationVndAllegroV1Json: String {
        "application/vnd.allegro.public.v1+json"
    }

    static var applicationJson: String {
        "application/json"
    }

    static var applicationPdf: String {
        "application/pdf"
    }

    static var imagePng: String {
        "image/png"
    }

    static var imageJpeg: String {
        "image/jpeg"
    }

    static var imageGif: String {
        "image/gif"
    }

    static var imageTiff: String {
        "image/tiff"
    }

    static var imageBmp: String {
        "image/bmp"
    }

    static func bearer(_ token: String) -> String {
        "Bearer \(token)"
    }

    /// `"Basic credentials_string"`
    static func basic(_ credentials: String) -> String {
        "Basic \(credentials)"
    }
}
