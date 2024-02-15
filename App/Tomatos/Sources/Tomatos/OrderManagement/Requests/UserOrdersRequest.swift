// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/getListOfOrdersUsingGET
struct UserOrdersRequest: Request {
    typealias Output = UserOrdersRequest.Response

    var path: String {
        "/order/checkout-forms"
    }

    var headerFields: HTTPFields = [
        HTTPField.Name.accept : .applicationVndAllegroV1Json
    ]
}

extension UserOrdersRequest {

    struct Response: ContentType {
        let checkoutForms: [CheckoutForm]
        let count: Int
        let totalCount: Int
    }
}
