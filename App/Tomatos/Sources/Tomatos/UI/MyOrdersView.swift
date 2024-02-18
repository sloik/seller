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

        ScrollView {

            ForEach(store.forms) { (form: CheckoutForm) in
                VStack {
                    let offer: SellersOffer? = store.state.sellerOffer(for: form)

                    FormView(
                        form: form,
                        offer: offer
                    )
                }
            }
            .padding()

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

        let buyer = form.buyer

        switch (buyer.firstName, buyer.lastName) {
        case (let first?, let last?):
            return "\(first) \(last)"

        case (let first?, .none):
            return first

        case (.none, let last?):
            return last

        case (.none, .none):
            return buyer.id
        }
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

            VStack(alignment: .leading) {
                offer
                    .map(\.name)
                    .or( "NO OFFER NAME" )

                VStack(alignment: .textAlignmentGuide) {
                    HStack {
                        "Klient:"
                            .design(typography: .body(weight: .regular))
                        client
                            .design(typography: .body(weight: .regular))
                            .alignmentGuide(.textAlignmentGuide) { context in
                                context[.leading]
                            }

                        // Fixed an issue when client name would not wrap.
                        // I did try other solutions but none of them did the job.
                        Spacer()
                    }

                    HStack {
                        "Otrzymane:"
                            .design(typography: .body(weight: .regular))
                        form.updatedAt.or("-")
                            .design(typography: .body(weight: .regular))
                            .alignmentGuide(.textAlignmentGuide) { context in
                                context[.leading]
                            }
                    }

                    HStack {
                        "Zrealizowane:"
                            .design(typography: .body(weight: .regular))
                        status
                            .design(typography: .body(weight: .regular))
                            .alignmentGuide(.textAlignmentGuide) { context in
                                context[.leading]
                            }
                    }
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

private extension HorizontalAlignment {

    private struct TextAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.leading]
        }
    }

    static let textAlignmentGuide = HorizontalAlignment(
        TextAlignment.self
    )
}
