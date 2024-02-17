
import Foundation
import ComposableArchitecture

extension OrdersFeature {
    
    @ObservableState
    struct State: Equatable {
        var forms   : [CheckoutForm] = []
        var offers  : [SellersOffer] = []
    }

}
