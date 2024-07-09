
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
            String.localized("unpaid")

        case .filledIn:
            String.localized("filled")

        case .readyForProcessing:
            String.localized("paid")

        case .cancelled:
            String.localized("cancelled_payment")
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

                OrderDetailTitle(title: String.localized("buyer_data"))

                VStack(spacing: 0) {
                    OrderDetailRow(title: String.localized("name_surname"), text: client)
                    Divider()
                    OrderDetailRow(title: String.localized("street"), text: street)
                    Divider()
                    OrderDetailRow(title: String.localized("zip_code"), text: postalCode)
                    Divider()
                    OrderDetailRow(title: String.localized("city"), text: city)
                    Divider()
                    OrderDetailRow(title: String.localized("phone_number"), text: phoneNumber)
                    Divider()
                    OrderDetailRow(title: String.localized("email"), text: email)
                    Divider()
                }.padding(.all, 16)

                OrderDetailTitle(title:  String.localized("delivery_details"))

                OrderDetailRow(title: String.localized("time_of_shipment"), text: timeOfShipment)
                Divider()
                OrderDetailRow(title: String.localized("time_of_delivery"), text: timeOfDelivery)
                Divider()
                OrderDetailRow(title: String.localized("pickup_point"), text: pickupPoint)
                Divider()
                OrderDetailRow(title:  String.localized("shipping_time2"), text: timeOfShipment2)
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
                        Label(String.localized("copy_to_clipboard"), systemImage: "doc.on.doc")
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
