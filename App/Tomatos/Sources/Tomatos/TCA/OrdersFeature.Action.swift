
import Foundation
import ComposableArchitecture

extension OrdersFeature {
    
    enum Action: Equatable {

        /// User wants to fetch and display lates orders information.
        case refreshOrdersList

        /// Result of refreshing orders list.
        case refreshOrdersListResponse(forms: [CheckoutForm])


        case refreshSellerOffers

        case refreshSellerOffersResponse(offers: [SellersOffer])
    }

}
