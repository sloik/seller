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

                ForEach(store.forms) { form in
                    VStack {
                        FormView(form: form, offers: store.offers)
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
    let offers: [SellersOffer]

    var offer: SellersOffer? {
        form
            .lineItems
            .map(\.offer)
            .compactMap { (offer: CheckoutForm.LineItem.Offer) in
                offers
                    .first { sellerOffer in
                        sellerOffer.id == offer.id
                    }
            }
            .first
    }

    var imageURL: URL {
            offer?
                .primaryImage
                .asURL
                ?? bostonURL
    }

    var body: some View {
        "\(form.buyer.login)"

        HStack {
            
            BostonImageView(imgURL: imageURL)

            VStack {
                form.buyer.firstName ?? "-"
                form.buyer.lastName ?? "-"

            }

        }
    }
}

private let bostonURL: URL = URL(string:  "https://previews.123rf.com/images/denisdore/denisdore1109/denisdore110900007/10629857-male-baby-boston-terrier-on-white-vertical.jpg")!

struct BostonImageView: View {
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
