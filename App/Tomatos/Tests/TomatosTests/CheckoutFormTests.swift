import XCTest
@testable import Tomatos

import Onion

final class CheckoutFormTests: XCTestCase {

    func test_parsingJsonExample() throws {

        // Arrange
        let jsonString = """
            {
              "id": "29738e61-7f6a-11e8-ac45-09db60ede9d6",
              "messageToSeller": "Please send me an item in red color",
              "buyer": {
                "id": "23123123",
                "email": "user-email@allegro.pl",
                "login": "User_Login",
                "firstName": "Jan",
                "lastName": "Kowalski",
                "companyName": "Evil Corp",
                "guest": false,
                "personalIdentity": "67062589524",
                "phoneNumber": "555-444-555",
                "preferences": {
                  "language": "pl-PL"
                },
                "address": {
                  "street": "Solna",
                  "city": "Poznań",
                  "postCode": "60-166",
                  "countryCode": "PL"
                }
              },
              "payment": {
                "id": "0f8f1d13-7e9e-11e8-9b00-c5b0dfb78ea6",
                "type": "CASH_ON_DELIVERY",
                "provider": "P24",
                "finishedAt": "2018-10-12T10:12:32.321Z",
                "paidAmount": {
                  "amount": "123.45",
                  "currency": "PLN"
                },
                "reconciliation": {
                  "amount": "123.45",
                  "currency": "PLN"
                }
              },
              "status": "READY_FOR_PROCESSING",
              "fulfillment": {
                "status": "SENT",
                "shipmentSummary": {
                  "lineItemsSent": "SOME"
                }
              },
              "delivery": {
           "address": {
             "firstName": "Jan",
             "lastName": "Kowalski",
             "street": "Grunwaldzka 182",
             "city": "Poznań",
             "zipCode": "60-166",
             "countryCode": "PL",
             "companyName": "Evil Corp",
             "phoneNumber": "555-444-555",
             "modifiedAt": "2018-01-01T10:23:43.123Z"
           },
           "method": {
             "id": "1fa56f79-4b6a-4821-a6f2-ca9c16d5c925",
             "name": "Allegro Paczkomaty InPost"
           },
           "pickupPoint": {
             "id": "POZ08A",
             "name": "Paczkomat POZ08A",
             "description": "Stacja paliw BP",
             "address": {
               "street": "Grunwaldzka 108",
               "zipCode": "60-166",
               "city": "Poznań",
               "countryCode": "PL"
             }
           },
           "cost": {
             "amount": "124.45",
             "currency": "PLN"
           },
           "time": {
             "from": "2018-01-01T10:23:43.123Z",
             "to": "2018-01-05T10:23:43.123Z",
             "guaranteed": {
               "from": "2018-01-07T16:00:00Z",
               "to": "2018-01-08T18:00:00Z"
             },
             "dispatch": {
               "from": "2018-01-01T16:00:00Z",
               "to": "2018-01-03T18:00:00Z"
             }
           },
           "smart": true,
           "calculatedNumberOfPackages": 1
         },
              "invoice": {
                "required": true,
                "address": {
                  "street": "Grunwaldzka 182",
                  "city": "Poznań",
                  "zipCode": "60-166",
                  "countryCode": "PL",
                  "company": {
                    "name": "Udix Sp. z o.o.",
                    "taxId": "1234"
                  },
                  "naturalPerson": {
                    "firstName": "Jan",
                    "lastName": "Kowalski"
                  }
                },
                "dueDate": "2021-12-01"
              },
              "lineItems": [
                {
                  "id": "62ae358b-8f65-4fc4-9c77-bedf604a2e2b",
                  "offer": {
                    "id": "3213213",
                    "name": "Name of purchased offer",
                    "external": {
                      "id": "AH-129834"
                    },
                    "productSet": {
                      "products": [
                        {
                          "id": "9d689aa5-f2ad-4bdc-bb97-6b196854e6c7",
                          "quantity": 1
                        },
                        {
                          "id": "5924a344-1620-45fe-b214-186d4902c30b",
                          "quantity": 2
                        }
                      ]
                    }
                  },
                  "quantity": 1,
                  "originalPrice": {
                    "amount": "123.45",
                    "currency": "PLN"
                  },
                  "price": {
                    "amount": "123.45",
                    "currency": "PLN"
                  },
                  "reconciliation": {
                    "value": {
                      "amount": "123.45",
                      "currency": "PLN"
                    },
                    "type": "BILLING",
                    "quantity": 1
                  },
                  "selectedAdditionalServices": [
                    {
                      "definitionId": "CARRY_IN",
                      "name": "Wniesienie",
                      "price": {
                        "amount": "123.45",
                        "currency": "PLN"
                      },
                      "quantity": 1
                    }
                  ],
                  "vouchers": [
                    {
                      "code": "Code12345",
                      "type": "NOTEBOOKS_FOR_TEACHERS",
                      "status": "ACTIVE",
                      "externalTransactionId": "sampleExternalTransactionId",
                      "value": {
                        "amount": "123.45",
                        "currency": "PLN"
                      }
                    }
                  ],
                  "boughtAt": "2018-01-01T10:23:43.123Z"
                }
              ],
              "surcharges": [
                {
                  "id": "0f8f1d13-7e9e-11e8-9b00-c5b0dfb78ea6",
                  "type": "CASH_ON_DELIVERY",
                  "provider": "P24",
                  "finishedAt": "2018-10-12T10:12:32.321Z",
                  "paidAmount": {
                    "amount": "123.45",
                    "currency": "PLN"
                  },
                  "reconciliation": {
                    "amount": "123.45",
                    "currency": "PLN"
                  }
                }
              ],
              "discounts": [
                {
                  "type": "COUPON"
                }
              ],
              "note": {
                "text": "Sample note"
              },
              "marketplace": {
                "id": "allegro-pl"
              },
              "summary": {
                "totalToPay": {
                  "amount": "124.45",
                  "currency": "PLN"
                }
              },
              "updatedAt": "2011-12-03T10:15:30.133Z",
              "revision": "819b5836"
            }
        """

        let expectedResult = CheckoutForm(
            id: "29738e61-7f6a-11e8-ac45-09db60ede9d6",
            messageToSeller: "Please send me an item in red color",
            buyer: CheckoutForm.Buyer(
                id: "23123123",
                email: "user-email@allegro.pl",
                login: "User_Login",
                firstName: "Jan",
                lastName: "Kowalski",
                companyName: "Evil Corp",
                guest: false,
                personalIdentity: "67062589524",
                phoneNumber: "555-444-555",
                preferences: CheckoutForm.Buyer.Preferences(
                    language: "pl-PL"
                ),
                address: Address(
                    street: "Solna",
                    city: "Poznań",
                    postCode: "60-166",
                    countryCode: "PL"
                )
            ),
            payment: CheckoutForm.Payment(
                id: "0f8f1d13-7e9e-11e8-9b00-c5b0dfb78ea6",
                type: .cashOnDelivery,
                provider: .p24,
                finishedAt: "2018-10-12T10:12:32.321Z",
                paidAmount: Price.pln123_45,
                reconciliation: Price.pln123_45
            ),
            status: .readyForProcessing,
            fulfillment: CheckoutForm.Fulfillment(
                status: .sent,
                shipmentSummary: CheckoutForm.Fulfillment.ShipmentSummary(lineItemsSent: .some)
            ),
            delivery: CheckoutForm.Delivery(
                address: CheckoutForm.Delivery.Address(
                    firstName: "Jan",
                    lastName: "Kowalski",
                    street: "Grunwaldzka 182",
                    city: "Poznań",
                    zipCode: "60-166",
                    countryCode: "PL",
                    companyName: "Evil Corp",
                    phoneNumber: "555-444-555",
                    modifiedAt: "2018-01-01T10:23:43.123Z"
                ),
                method: CheckoutForm.Delivery.Method(
                    id: "1fa56f79-4b6a-4821-a6f2-ca9c16d5c925",
                    name: "Allegro Paczkomaty InPost"
                ),
                pickupPoint: CheckoutForm.Delivery.PickupPoint(
                    id: "POZ08A",
                    name: "Paczkomat POZ08A",
                    description: "Stacja paliw BP",
                    address: Address2(
                        street: "Grunwaldzka 108",
                        zipCode: "60-166",
                        city: "Poznań",
                        countryCode: "PL"
                    )
                ),
                cost: Price.pln124_45,
                time: CheckoutForm.Delivery.Time(
                    from: "2018-01-01T10:23:43.123Z",
                    to: "2018-01-05T10:23:43.123Z",
                    guaranteed: TimeRange(
                        from: "2018-01-07T16:00:00Z",
                        to: "2018-01-08T18:00:00Z"
                    ),
                    dispatch: TimeRange(
                        from: "2018-01-01T16:00:00Z",
                        to: "2018-01-03T18:00:00Z"
                    )
                ),
                smart: true,
                calculatedNumberOfPackages: 1
            ),
            invoice: CheckoutForm.Invoice(
                required: true,
                address: CheckoutForm.Invoice.Address(
                    street: "Grunwaldzka 182",
                    city: "Poznań",
                    zipCode: "60-166",
                    countryCode: "PL",
                    company: Company(
                        name: "Udix Sp. z o.o.",
                        taxId: "1234"
                    ),
                    naturalPerson: NaturalPerson(
                        firstName: "Jan",
                        lastName: "Kowalski"
                    )
                ),
                dueDate: "2021-12-01"
            ),
            lineItems: [
                CheckoutForm.LineItem(
                    id: "62ae358b-8f65-4fc4-9c77-bedf604a2e2b",
                    offer: CheckoutForm.LineItem.Offer(
                        id: "3213213",
                        name: "Name of purchased offer",
                        external: Identifier<CheckoutForm.LineItem.Offer.External>(id:"AH-129834"),
                        productSet: CheckoutForm.LineItem.Offer.ProductSet(
                            products: [
                                CheckoutForm.LineItem.Offer.ProductSet.Product(
                                    id: "9d689aa5-f2ad-4bdc-bb97-6b196854e6c7",
                                    quantity: 1
                                ),
                                CheckoutForm.LineItem.Offer.ProductSet.Product(
                                    id: "5924a344-1620-45fe-b214-186d4902c30b",
                                    quantity: 2
                                )
                            ]
                        )
                    ),
                    quantity: 1,
                    originalPrice: Price.pln123_45,
                    price: Price.pln123_45,
                    reconciliation: CheckoutForm.LineItem.Reconciliation(
                        value: Price.pln123_45,
                        type: .billing,
                        quantity: 1
                    ),
                    selectedAdditionalServices: [
                        CheckoutForm.LineItem.AdditionalService(
                            definitionId: "CARRY_IN",
                            name: "Wniesienie",
                            price: Price.pln123_45,
                            quantity: 1
                        )
                    ],
                    vouchers: [
                        CheckoutForm.LineItem.Voucher(
                            code: "Code12345",
                            type: .notebooksForTeachers,
                            status: .active,
                            externalTransactionId: "sampleExternalTransactionId",
                            value: Price.pln123_45
                        )
                    ],
                    boughtAt: "2018-01-01T10:23:43.123Z"
                )
            ],
            surcharges: [
                CheckoutForm.Surcharge(
                    id: "0f8f1d13-7e9e-11e8-9b00-c5b0dfb78ea6",
                    type: "CASH_ON_DELIVERY",
                    provider: .p24,
                    finishedAt: "2018-10-12T10:12:32.321Z",
                    paidAmount: Price.pln123_45,
                    reconciliation: Price.pln123_45
                )
            ],
            discounts: [
                CheckoutForm.Discount(type: .coupon)
            ],
            note: CheckoutForm.Note(text: "Sample note"),
            marketplace: Identifier<CheckoutForm.Marketplace>(id: "allegro-pl"),
            summary: CheckoutForm.Summary(totalToPay: Price.pln124_45),
            updatedAt: "2011-12-03T10:15:30.133Z",
            revision: "819b5836"
        )

        // Act
        let result = try! JSONDecoder().decode(CheckoutForm.self, from: jsonString.data(using: .utf8)!)

        // Assert
        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(result.buyer, expectedResult.buyer)

        XCTAssertEqual(result.delivery!, expectedResult.delivery!)
        XCTAssertEqual(result.delivery!.address, expectedResult.delivery!.address)
        XCTAssertEqual(result.delivery!.method, expectedResult.delivery!.method)
        XCTAssertEqual(result.delivery!.pickupPoint, expectedResult.delivery!.pickupPoint)
        XCTAssertEqual(result.delivery!.cost, expectedResult.delivery!.cost)
        XCTAssertEqual(result.delivery!.time, expectedResult.delivery!.time)
        XCTAssertEqual(result.delivery!.smart, expectedResult.delivery!.smart)
        XCTAssertEqual(result.delivery!.calculatedNumberOfPackages, expectedResult.delivery!.calculatedNumberOfPackages)

        XCTAssertEqual(result.invoice, expectedResult.invoice)
        XCTAssertEqual(result.lineItems, expectedResult.lineItems)
        XCTAssertEqual(result.surcharges, expectedResult.surcharges)
        XCTAssertEqual(result.discounts, expectedResult.discounts)
        XCTAssertEqual(result.note, expectedResult.note)
        XCTAssertEqual(result.marketplace, expectedResult.marketplace)
        XCTAssertEqual(result.summary, expectedResult.summary)
        XCTAssertEqual(result.updatedAt, expectedResult.updatedAt)
        XCTAssertEqual(result.revision, expectedResult.revision)
    }


    }

    func test_parsingJson_for_CheckoutFormFulfillment() {

        // arrange
        let jsonString = """
           {
            "status": "SENT",
            "shipmentSummary": {
              "lineItemsSent": "SOME"
            }
          }
        """

        let expected = CheckoutForm.Fulfillment(
            status: .sent,
            shipmentSummary: CheckoutForm.Fulfillment.ShipmentSummary(lineItemsSent: .some)
        )

        // act
        let result = try! JSONDecoder().decode(CheckoutForm.Fulfillment.self, from: jsonString.data(using: .utf8)!)

        // assert
        XCTAssertEqual(result, expected)
    }
