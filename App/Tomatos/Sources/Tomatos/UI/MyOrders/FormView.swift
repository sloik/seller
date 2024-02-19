
import SwiftUI

private let bostonURL: URL = URL(string:  "https://previews.123rf.com/images/denisdore/denisdore1109/denisdore110900007/10629857-male-baby-boston-terrier-on-white-vertical.jpg")!

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
                    TextAlignedView(
                        key: "Klient",
                        value: client
                    )

                    TextAlignedView(
                        key: "Otrzymane",
                        value: form.updatedAt.or("-")
                    )

                    TextAlignedView(
                        key: "Zrealizowane",
                        value: status
                    )
                }
            }
        }
    }
}
