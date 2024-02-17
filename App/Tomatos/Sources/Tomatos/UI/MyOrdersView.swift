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
                        let offer = store.state.sellerOffer(for: form)

                        FormView(
                            login: form.buyer.login,
                            firstName: form.buyer.firstName ?? "-",
                            lastName: form.buyer.lastName ?? "-",
                            imageURL: offer?.primaryImage.asURL ?? bostonURL
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


    let login       : String
    let firstName   : String
    let lastName    : String
    let imageURL    : URL

    var client: String {
        [login, firstName, lastName].joined(separator: " ")
    }

    var body: some View {

        HStack {

            OfferImage(imgURL: imageURL)
                .frame(maxWidth: 100, maxHeight: 100)

            VStack {
                "Offer title"
                HStack {
                    "Klient:"
                    client
                }

                HStack {
                    "Otrzymane:"
                    "07.12.2023, 17:30"
                }

                HStack {
                    "Zrealizowane:"
                    "nieopłacone"
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
