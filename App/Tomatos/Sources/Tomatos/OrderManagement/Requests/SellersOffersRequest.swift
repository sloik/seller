// system
import Foundation
import HTTPTypes

// local
import Onion

/// https://developer.allegro.pl/documentation#operation/searchOffersUsingGET
struct SellersOffersRequest: Request {
    typealias Output = SellersOffersRequest.Response

    var path: String {
        "/sale/offers"
    }

    var headerFields: HTTPFields = [
        HTTPField.Name.accept : .applicationVndAllegroV1Json
    ]
}

extension SellersOffersRequest {

    struct Response: ContentType {
        let offers: [Offer]
        let count: Int
        let totalCount: Int
    }
}


typealias SellersOffer = SellersOffersRequest.Response.Offer
extension SellersOffersRequest.Response {

    struct Offer: ContentType, Identifiable {
        let id: String
        let name: String

        /// The image used as a thumbnail on the listings.
        let primaryImage: JsonURL

        // TODO: Add rest of the DTO
    }
}
