// system
import SwiftUI

import ComposableArchitecture
import OptionalAPI

struct MyOrdersView {

    private let store: StoreOf<OrdersFeature>

    init(store: StoreOf<OrdersFeature>) {
        self.store = store
    }
}

extension MyOrdersView: View {
    public var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 0) {

                    ForEach(store.forms) { (form: CheckoutForm) in
                        NavigationLink {
                            "Next View"
                        } label: {
                            let offer: SellersOffer? = store.state.sellerOffer(for: form)

                            FormView(
                                form: form,
                                offer: offer
                            )
                        }

                    }
                }
            }
        }
        .onAppear {
            store.send(.refreshSellerOffers)
            store.send(.refreshOrdersList)
        }
    }
}

#Preview {
    MyOrdersView(
        store: Store(
            initialState: OrdersFeature.State()
        ) {}
    )
}
