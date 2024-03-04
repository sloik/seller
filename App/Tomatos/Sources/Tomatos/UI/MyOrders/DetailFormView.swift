
import SwiftUI
import UniformTypeIdentifiers
import Utilities

struct DetailFormView: View {

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
        form.delivery?.time?.dispatch?.from?.isoDate?.design(formatter: .date)  ?? ""
    }

    var timeOfShipment: String {
        form.delivery?.time?.to?.isoDate?.design(formatter: .date)  ?? ""
    }

    var timeOfShipment2: String {
        form.delivery?.time?.from?.isoDate?.design(formatter: .date)  ?? ""
    }

    var deliveryMethod: String {
        form.delivery?.method?.name ?? ""
    }

    var pickupPoint: String {
        form.delivery?.pickupPoint?.name ?? ""
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                FormView(form: form, offer: offer)

                OrderDetailTitle(title: "Dane kupującgo")

                VStack(spacing: 0) {
                    OrderDetailRow(title: "Imię i nazwisko", text: client)
                    Divider()
                    OrderDetailRow(title: "Ulica", text: street)
                    Divider()
                    OrderDetailRow(title: "Kod pocztowy", text: postalCode)
                    Divider()
                    OrderDetailRow(title: "Miasto", text: city)
                    Divider()
                    OrderDetailRow(title: "Nr telefonu", text: phoneNumber)
                    Divider()
                    OrderDetailRow(title: "E-mail", text: email)
                    Divider()
                }.padding(.all, 16)

                OrderDetailTitle(title:  "Dane dostawy")

                OrderDetailRow(title: "Czas wysyłki", text: timeOfShipment)
                Divider()
                OrderDetailRow(title: "Czas dostawy", text: timeOfDelivery)
                Divider()
                OrderDetailRow(title: "Pickup point", text: pickupPoint)
                Divider()
                OrderDetailRow(title: "Czas wysyłki 2", text: timeOfShipment2)
                Divider()
            }
            .background(.design(color: .gray91, with: colorScheme))
        }
        .padding(.horizontal, 16)
    }
}

struct OrderDetailRow: View {
    @Environment(\.colorScheme) private var colorScheme

    private let title: String
    private let text: String

    init(title: String, text: String) {
        self.title = title
        self.text = text
    }

    var body: some View {
        VStack(spacing: 0) {
            title
                .design(padding: .smaller(.horizontal))
                .design(padding: .tiny(.vertical))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.design(color: .gray71, with: colorScheme))
            text
                .design(padding: .smaller(.horizontal))
                .design(padding: .tiny(.vertical))
                .frame(maxWidth: .infinity, alignment: .leading)
                .contextMenu {
                    Button {
                        UIPasteboard.general.setValue(text,
                                                      forPasteboardType: UTType.plainText.identifier)
                    } label: {
                        Label("Skopiuj do schowka", systemImage: "doc.on.doc")
                    }
                }
                .background(Color.white)
        }
    }
}

struct OrderDetailTitle: View {
    let title: String

    var body: some View {
        title
            .design(typography: .bigTitle(weight: .regular))
            .design(padding: .base(.vertical))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
