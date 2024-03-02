
import SwiftUI
import UniformTypeIdentifiers

struct DetailFormView: View {

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

    var street: String {
        form.buyer.address?.street ?? ""
    }

    var postalCode: String {
        form.buyer.address?.postCode ?? ""
    }

    var city: String {
        form.buyer.address?.city ?? ""
    }

    var phoneNumber: String {
        form.buyer.phoneNumber ?? ""
    }

    var email: String {
        form.buyer.email
    }

    var timeOfDelivery: String {
        form.delivery?.time?.dispatch?.from ?? ""
    }

    var timeOfShipment: String {
        form.delivery?.time?.to ?? ""
    }


    var timeOfShipment2: String {
        form.delivery?.time?.from ?? ""
    }

    var deliveryMethod: String {
        form.delivery?.method?.name ?? ""
    }

    var pickupPoint: String {
        form.delivery?.pickupPoint?.name ?? ""
    }

    var body: some View {
        VStack(spacing: 0) {
            Grid(alignment: .leading) {
                GridRow {
                    Text("Imię i nazwisko")
                        .frame(alignment: .leading)
                    client
                        .contextMenu {
                            Button {
                                UIPasteboard.general.setValue(client,
                                    forPasteboardType: UTType.plainText.identifier)
                            } label: {
                                Label("Copy text", systemImage: "globe")
                            }
                        }


                }

                GridRow {
                    Text("Ulica")
                    street
                }
                Divider()
                GridRow {
                    Text("Kod pocztowy")
                    postalCode
                }

                Divider()
                GridRow {
                    Text("Miasto")
                    city
                }

                Divider()
                GridRow {
                    Text("Nr telefonu")
                    phoneNumber
                }

                Divider()
                GridRow {
                    Text("E-mail")
                        .lineLimit(4)
                    email
                }
                Divider()

                GridRow {
                                  Text("Czas dostawy")
                                      .frame(alignment: .leading)
                                  timeOfDelivery

                              }
                Divider()

            }

//            "Dane kupującego"
//                .padding(.vertical, 12)
//                .background(Color.secondary)
//
//            Grid(alignment: .leading) {
//                GridRow {
//                    Text("Czas dostawy")
//                        .frame(alignment: .leading)
//                    timeOfDelivery
//
//                }
//                Divider()
//
//                GridRow {
//                    Text("Czas wysyłki")
//                        .frame(alignment: .leading)
//                    timeOfShipment
//                    timeOfShipment2
//
//                }
//                Divider()
//
//                GridRow {
//                    Text("Pickup point")
//                        .frame(alignment: .leading)
//                    pickupPoint
//
//
//                }
//                Divider()
//
//                GridRow {
//                    Text("deliveryMethod")
//                        .frame(alignment: .leading)
//                    deliveryMethod
//
//                }
//                Divider()
//
//
//            }
//



        }
    }
}
