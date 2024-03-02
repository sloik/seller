
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
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                offer
                    .map(\.name)
                    .or( "NO OFFER NAME" )
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
                    .design(padding: .smaller(.bottom))

                HStack(spacing: 8) {

                    VStack(alignment: .leading, spacing: 0) {
                        "Klient"
                            .design(typography: .body(weight: .regular))
                            .lineLimit(1)

                            .frame(alignment: .leading)

                        "Otrzymane"
                            .design(typography: .body(weight: .regular))
                            .lineLimit(1)

                            .frame(alignment: .leading)

                        "Zamówienie"
                            .design(typography: .body(weight: .regular))
                            .lineLimit(1)

                            .frame(alignment: .leading)

                    }

                    .frame(alignment: .leading)


                    VStack(alignment: .leading, spacing: 0) {
                        client
                            .design(typography: .body(weight: .regular))
                            .lineLimit(1)
                            .frame(alignment: .leading)

                        form.updatedAt.or("-").isoDate?.design(formatter: .date)
                            .design(typography: .body(weight: .regular))
                            .lineLimit(1)
                            .frame(alignment: .leading)

                        status
                            .design(typography: .body(weight: .regular))
                            .lineLimit(1)
                            .frame(alignment: .leading)

                    }
                    .frame(alignment: .leading)


                }
            }
            .design(padding: .smaller(.leading))

        //    .background(Color.yellow)
             // .padding(.all, 8)


       //     Spacer()

          //  Spacer()

            OfferImage(imgURL: offer?.primaryImage.asURL ?? bostonURL)
                .frame(width: 100, height: 100)
            //    .padding(.horizontal, 9)

        }

           // .background(Color.cyan)
//.cornerRadius(15)

            //.padding(.all, 24)

        /*.frame(width: UIScreen().bounds.width)*/
    }
}
//
//
//
//HStack(spacing: 0) {
//    OfferImage(imgURL: offer?.primaryImage.asURL ?? bostonURL)
//        .background(Color.yellow)
//
//
//    VStack(alignment: .leading, spacing: 0) {
//        "BARDZO DLUGI STRING KTORY NIE WIELE ZNACZY STRING KTORY NIE WIELE ZNACZY STRING KTORY NIE WIELE ZNACZY STRING KTORY NIE WIELE ZNACZY STRING KTORY NIE WIELE ZNACZY"
//           // .map(\.name)
//          //  .or( "NO OFFER NAME" )
//            .lineLimit(3)
//
//        VStack(alignment: .textAlignmentGuide) {
//            TextAlignedView(
//                key: "Klient",
//                value: client
//            )
//
//            TextAlignedView(
//                key: "Otrzymane",
//                value: form.updatedAt.or("-")
//            )
//
//            TextAlignedView(
//                key: "Zrealizowane",
//                value: status
//            )
//        }
//    }
//    .background(Color.gray)
//
//}
//.background(Color.green)
//.frame(maxWidth: UIScreen.main.bounds.width - 20)
//
//// .frame(width: UIScreen.main.bounds.width)
//
//}
