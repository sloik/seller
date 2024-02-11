
// system
import Foundation

// local
import Onion

// https://developer.allegro.pl/documentation#operation/getListOfOrdersUsingGET
struct CheckoutForm: ContentType {

    let id: String
    let messageToSeller: String

    struct Buyer: ContentType {
        let id: String
        let email: String
        let login: String
        let firstName: String
        let lastName: String
        let companyName: String?
        let guest: Bool
        let personalIdentity: String
        let phoneNumber: String?

        struct Preferences: ContentType {
            let language: String
        }
        let preferences: Preferences

        let address: Address
    }
    let buyer: Buyer

    struct Payment: ContentType {
        let id: String
        let type: String
        let provider: String
        let finishedAt: String
        let paidAmount: Price
        let reconciliation: Price
    }
    let payment: Payment

    let status: String

    struct Fulfillment: ContentType {
        enum Status: String, ContentType {
            case sent = "SENT"
        }
        let status: Status
        let shipmentSummary: ShipmentSummary

        struct ShipmentSummary: ContentType {
            let lineItemsSent: String
        }
    }
    let fulfillment: Fulfillment

    struct Delivery: ContentType {
        struct Address: ContentType {
            let firstName: String
            let lastName: String
            let street: String
            let city: String
            let zipCode: String
            let countryCode: String
            let companyName: String?
            let phoneNumber: String?
            let modifiedAt: String?
        }
        let address: Address

        struct Method: ContentType {
            let id: String
            let name: String
        }
        let method: Method

        struct PickupPoint: ContentType {
            let id: String
            let name: String
            let description: String
            let address: Address
        }
        let pickupPoint: PickupPoint

        let cost: Price

        struct Time: ContentType {
            let from: String
            let to: String
            let guaranteed: TimeRange
            let dispatch: TimeRange
        }
        let time: Time

        let smart: Bool

        let calculatedNumberOfPackages: Int
    }
    let delivery: Delivery


    struct Invoice: ContentType {
        let required: Bool

        struct Address: ContentType {
            let street: String
            let city: String
            let zipCode: String
            let countryCode: String

            let company: Company?
            let naturalPerson: NaturalPerson?
        }
        let address: Address

        let dueDate: String
    }
    let invoice: Invoice

    struct LineItem: ContentType {
        let id: String

        struct Offer: ContentType {
            let id: String
            let name: String

            enum External {}
            let external: Identifier<External>

            struct ProductSet: ContentType {
                let products: [Product]

                struct Product: ContentType {
                    let id: String
                    let quantity: Int
                }
            }
            let productSet: ProductSet
        }
        let offer: Offer

        let quantity: Int

        let originalPrice: Price

        let price: Price

        struct Reconciliation: ContentType {
            let value: Price

            enum RType: String, ContentType {
                case billing = "BILLING"
            }
            let type: RType
            let quantity: Int
        }
        let reconciliation: Reconciliation

        struct AdditionalService: ContentType {
            let definitionId: String
            let name: String
            let price: Price
            let quantity: Int
        }
        let selectedAdditionalServices: [AdditionalService]

        struct Voucher: ContentType {
            let code: String
            let type: String

            enum Status: String, ContentType {
                case active = "ACTIVE"
            }
            let status: Status
            let externalTransactionId: String
            let value: Price
        }
        let vouchers: [Voucher]

        let boughtAt: String
    }
    let lineItems: [LineItem]

    struct Surcharge: ContentType {
        let id: String
        let type: String
        let provider: String
        let finishedAt: String
        let paidAmount: Price
        let reconciliation: Price
    }
    let surcharges: [Surcharge]

    struct Discount: ContentType {
        enum DType: String, ContentType {
            case coupon = "COUPON"
        }
        let type: DType
    }
    let discounts: [Discount]

    struct Note: ContentType {
        let text: String
    }
    let note: Note

    enum Marketplace {}
    let marketplace: Identifier<Marketplace>

    struct Summary: ContentType {
        let totalToPay: Price
    }
    let summary: Summary

    let updatedAt: String

    let revision: String
}
