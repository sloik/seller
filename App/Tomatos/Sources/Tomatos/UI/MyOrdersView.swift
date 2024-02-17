// system
import SwiftUI

import ComposableArchitecture

struct MyOrdersView {

    private let store: StoreOf<OrdersFeature>

    init(store: StoreOf<OrdersFeature>) {
        self.store = store
    }
}

extension MyOrdersView: View {
    public var body: some View {
        
        VStack() {
            Text("My orders")

            ScrollView {

                ForEach(store.forms) { (form: CheckoutForm) in
                    VStack {
                        let offer: SellersOffer? = store.state.sellerOffer(for: form)

                        FormView(
                            form: form,
                            offer: offer
                        )
                        .padding()
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

struct FormView: View {

    let form: CheckoutForm
    let offer: SellersOffer?

    var client: String {
        [
            form.buyer.id,
            form.buyer.firstName ?? "-",
            form.buyer.lastName ?? "-",
        ].joined(separator: " ")
    }

    var status: String {

        switch form.status {
        case .bought:
            "Nieopłacony"

        case .filledIn:
            "Wypełniony"

        case .readyForProcessing:
            "Opłacone"

        case .cancelled:
            "Płatność anulowana"
        }

    }

    var body: some View {

        HStack {

            OfferImage(imgURL: offer?.primaryImage.asURL ?? bostonURL)
                .frame(maxWidth: 100, maxHeight: 100)

            VStack {
                offer?.name ?? "NO OFFER NAME"
                HStack {
                    "Klient:"
                    client
                }

                HStack {
                    "Otrzymane:"
                    form.updatedAt ?? "-"
                }

                HStack {
                    "Zrealizowane:"
                    status
                }
            }
        }
    }
}

private let bostonURL: URL = URL(string:  "https://previews.123rf.com/images/denisdore/denisdore1109/denisdore110900007/10629857-male-baby-boston-terrier-on-white-vertical.jpg")!

struct OfferImage: View {
    let imgURL: URL

    var body: some View {
        AsyncImage(
            url: imgURL,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}
