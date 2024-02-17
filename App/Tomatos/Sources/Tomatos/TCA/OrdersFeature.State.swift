
import Foundation
import ComposableArchitecture

extension OrdersFeature {
    
    @ObservableState
    struct State: Equatable {
        var forms   : [CheckoutForm] = []
        var offers  : [SellersOffer] = []
    }

}


extension OrdersFeature.State {

    func sellerOffer(for form: CheckoutForm) -> SellersOffer? {
        offers
            .firstIndex { offer in
                form.lineItems.map(\.offer.id).contains(offer.id)
            }
            .map { index in
                offers[index]
            }
    }
}
