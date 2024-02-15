import Foundation

import Onion

enum PaymentProvider: String, ContentType {
    case p24 = "P24"
    case payu = "PAYU"
    case offline = "OFFLINE"
    case ept = "EPT"
}
