// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/getListOfOrdersUsingGET
struct UserOrdersRequests: Request {
    typealias Output = String

    var path: String {
        "/order/checkout-forms"
    }

    var headerFields: HTTPFields = [:]
}
