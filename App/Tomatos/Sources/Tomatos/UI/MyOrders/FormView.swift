
import SwiftUI

private let bostonURL: URL = URL(string:  "https://previews.123rf.com/images/denisdore/denisdore1109/denisdore110900007/10629857-male-baby-boston-terrier-on-white-vertical.jpg")!

struct FormView: View {

    let form: CheckoutForm
    let offer: SellersOffer?
    @Environment(\.colorScheme) private var colorScheme

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
        HStack(alignment: .top, spacing: 0) {
            OfferImage(imgURL: offer?.primaryImage.asURL ?? bostonURL)
                .design(padding: .base([.horizontal, .top]))

            VStack(alignment: .leading, spacing: 0) {
                offerNameView

                Grid(horizontalSpacing: 16) {
                    gridRow(label: "Klient", value: client)
                        .design(padding: .tiny(.bottom))

                    gridRow(label: "Otrzymane", value: form.updatedAt.or("-").isoDate?.design(formatter: .date))
                        .design(padding: .tiny(.bottom))

                    gridRow(label: "Zrealizowane", value: status)
                        .design(padding: .base(.bottom))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.white)
        .cornerRadius(8)
    }

    private var offerNameView: some View {
        offer
            .map(\.name)
            .or("NO OFFER NAME")
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(3)
            .design(padding: .base(.vertical))
            .design(typography: .body(weight: .regular))
    }

    private func gridRow(label: String, value: String?) -> some View {
        GridRow {
            label
                .gridCellAnchor(UnitPoint(x: 0, y: 0.5))
                .foregroundStyle(.design(color: .gray111213, with: colorScheme))
                .design(typography: .smallerLabel(weight: .regular))

            value
                .gridCellAnchor(UnitPoint(x: 0, y: 0.5))
                .design(typography: .mediumLabel(weight: .regular))
        }
    }
}
