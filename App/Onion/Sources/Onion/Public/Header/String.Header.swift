
import Foundation

public extension String {

    static var applicationVndAllegroV1Json: String {
        "application/vnd.allegro.public.v1+json"
    }

    static func bearer(_ token: String) -> String {
        "Bearer \(token)"
    }
}
