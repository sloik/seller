// system
import SwiftUI

import ComposableArchitecture
import OptionalAPI

struct MyOrdersView {

    private let store: StoreOf<OrdersFeature>
    @Environment(\.colorScheme) private var colorScheme

    init(store: StoreOf<OrdersFeature>) {
        self.store = store
    }
}

extension MyOrdersView: View {
    public var body: some View {
        NavigationStack {
            ZStack {
                Color(.design(color: .gray92, with: colorScheme))
                    .ignoresSafeArea(.all)

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(store.forms) { (form: CheckoutForm) in
                            NavigationLink {
                                DetailFormView(
                                    form: form,
                                    offer: store.state.sellerOffer(for: form)
                                )
                            } label: {
                                let offer: SellersOffer? = store.state.sellerOffer(for: form)

                                FormView(
                                    form: form,
                                    offer: offer
                                )
                                .padding(.bottom, 8)
                                .padding(.horizontal, 16)
                            }
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
