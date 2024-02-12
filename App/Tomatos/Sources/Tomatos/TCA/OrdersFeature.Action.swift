
import Foundation
import ComposableArchitecture

extension OrdersFeature {
    
    enum Action: Equatable {

        /// User wants to fetch and display lates orders information.
        case refreshOrdersList

        /// Result of refreshing orders list.
        case refreshedResponse(forms: [CheckoutForm])
    }

}
