
import Foundation

import Onion

struct Address: ContentType {
    let street: String
    let city: String
    let postCode: String
    let countryCode: String
}


struct Address2: ContentType {
    let street: String
    let zipCode: String
    let city: String
    let countryCode: String
}
