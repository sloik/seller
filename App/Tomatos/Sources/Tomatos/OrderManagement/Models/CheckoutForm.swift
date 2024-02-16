
// system
import Foundation

// local
import Onion

// https://developer.allegro.pl/documentation#operation/getListOfOrdersUsingGET
struct CheckoutForm: ContentType, Identifiable {

    let id: String
    let messageToSeller: String?

    struct Buyer: ContentType, Identifiable {
        let id: String
        let email: String
        let login: String
        let firstName: String?
        let lastName: String?
        let companyName: String?
        let guest: Bool
        /// Buyer's personal identity number (PESEL)
        let personalIdentity: String?
        let phoneNumber: String?

        struct Preferences: ContentType {
            let language: String?
        }
        let preferences: Preferences?

        let address: Address?
    }
    let buyer: Buyer

    struct Payment: ContentType, Identifiable {
        let id: String
        let type: PaymentType
        let provider: PaymentProvider?
        let finishedAt: String?
        let paidAmount: Price?
        let reconciliation: Price?
    }
    let payment: Payment?

    /// Describes status of the form delivery and purchase options based
    /// on payment and purchase status.
    enum Status: String, ContentType {
        /// Purchase without checkout form filled in.
        case bought = "BOUGHT"
        /// Checkout form filled in but payment is not completed
        /// yet so data could still change.
        case filledIn = "FILLED_IN"
        /// Payment completed. Purchase is ready for processing.
        case readyForProcessing = "READY_FOR_PROCESSING"
        /// Purchase cancelled by buyer.
        case cancelled = "CANCELLED"
    }
    let status: Status

    struct Fulfillment: ContentType {

        /// Order seller status.
        enum Status: String, ContentType {
            case sent = "SENT"
            case new = "NEW"
            case processing = "PROCESSING"
            case readyForShipment = "READY_FOR_SHIPMENT"
            case readyForPickup = "READY_FOR_PICKUP"
            case pickedUp = "PICKED_UP"
            case cancelled = "CANCELLED"
            case suspended = "SUSPENDED"
        }
        let status: Status?

        struct ShipmentSummary: ContentType {

            /// Indicates how many line items have tracking number specified.
            enum LineItemsReady: String, ContentType {
                case all = "ALL"
                case none = "NONE"
                case some = "SOME"
            }
            let lineItemsSent: LineItemsReady?
        }
        let shipmentSummary: ShipmentSummary?
    }
    let fulfillment: Fulfillment?

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
        let address: Address?

        struct Method: ContentType, Identifiable {
            let id: String?
            let name: String?
        }
        let method: Method?

        struct PickupPoint: ContentType, Identifiable {
            let id: String?
            let name: String?
            let description: String?
            let address: Address2?
        }
        let pickupPoint: PickupPoint?

        let cost: Price?

        struct Time: ContentType {
            /// ISO date when the earliest delivery attempt can take place.
            let from: String?
            /// ISO date when the latest delivery attempt can take place.
            let to: String?

            @available(*, deprecated, message: "Guaranteed date when first delivery attempt takes place. This is always filled for Allegro One Courier delivery method. This field is deprecated in favor of `delivery.time.from` and `delivery.time.to`")
            let guaranteed: TimeRange?
            /// Dates when delivery should be dispatched, passed to the provider.
            let dispatch: TimeRange?
        }
        let time: Time?

        let smart: Bool?

        let calculatedNumberOfPackages: Int32?
    }
    let delivery: Delivery?


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
        let address: Address?

        /// Due date to put on an invoice for Extended Payment Terms purchases.
        /// For other payment methods this field will be null.
        let dueDate: String?
    }
    let invoice: Invoice?

    struct LineItem: ContentType, Identifiable {
        let id: String

        struct Offer: ContentType, Identifiable {
            let id: String
            let name: String

            enum External {}
            /// The information on the offer in an external system.
            let external: Identifier<External>?

            struct ProductSet: ContentType {
                let products: [Product]

                struct Product: ContentType {
                    let id: String
                    /// Product quantity in a product set `>= 1`.
                    let quantity: Int?
                }
            }
            /// If the offer was a product set, you can see a list
            /// of component products (product id with quantity).
            let productSet: ProductSet?
        }
        let offer: Offer

        /// `>= 1`
        let quantity: Int

        let originalPrice: Price

        let price: Price

        struct Reconciliation: ContentType {
            let value: Price?

            enum RType: String, ContentType {
                /// A reconciliation value is counted as a new entry in the billing.
                case billing = "BILLING"
                /// A reconciliation value is added to the checkout form payment.
                case wallet = "WALLET"
            }
            /// Reconciliation type used in the Allegro Prices program,
            /// in which the offer is included.
            let type: RType
            let quantity: Int?
        }
        let reconciliation: Reconciliation?

        struct AdditionalService: ContentType {
            let definitionId: String?
            let name: String?
            let price: Price?
            let quantity: Int?
        }
        let selectedAdditionalServices: [AdditionalService]?

        struct Voucher: ContentType {
            let code: String

            enum VType: String, ContentType {
                /// A voucher for teacher's notebook action.
                case notebooksForTeachers = "NOTEBOOKS_FOR_TEACHERS"
            }
            /// Describes the types of vouchers used in the lineItems.
            let type: VType?

            enum Status: String, ContentType {
                case active = "ACTIVE"
                case canceled = "CANCELED"
            }
            let status: Status?
            let externalTransactionId: String?
            let value: Price?
        }
        let vouchers: [Voucher]?

        /// ISO date when offer was bought
        let boughtAt: String
    }
    let lineItems: [LineItem]

    struct Surcharge: ContentType, Identifiable {
        let id: String
        let type: String
        let provider: PaymentProvider?
        let finishedAt: String?
        let paidAmount: Price?
        let reconciliation: Price?
    }
    let surcharges: [Surcharge]

    struct Discount: ContentType {
        enum DType: String, ContentType {
            /// A coupon was used during payment.
            case coupon = "COUPON"
            /// Some items were bought as a bundle.
            case bundle = "BUNDLE"
            /// At least one item was bought with a multipack option turned on.
            case multipack = "MULTIPACK"
            /// Some items, each from a different offer, were bought together as a multipack
            case crossmultipack = "CROSSMULTIPACK"
            /// Some items are included in the Allegro Prices program
            case allegroPrices = "ALLEGRO_PRICES"
        }
        /// Describes the types of discounts used in the checkout form.
        let type: DType
    }
    let discounts: [Discount]

    struct Note: ContentType {
        let text: String?
    }
    let note: Note?

    enum Marketplace {}
    let marketplace: Identifier<Marketplace>?

    struct Summary: ContentType {
        let totalToPay: Price
    }
    let summary: Summary

    let updatedAt: String?

    let revision: String?
}
