import Foundation

import Onion

enum PaymentType: String, ContentType {
    case cashOnDelivery = "CASH_ON_DELIVERY"
    case wireTransfer = "WIRE_TRANSFER"
    case online = "ONLINE"
    case splitPayment = "SPLIT_PAYMENT"
    case extendedTerm = "EXTENDED_TERM"
}
