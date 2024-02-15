
// system
import Foundation

// local
import Onion

struct Price: ContentType {
    /// The amount provided in a string format to avoid rounding errors.
    let amount: String
    /// The currency provided as a 3-letter code in accordance with ISO 4217 standard.
    let currency: String
}

extension Price {

    /// 124.45 PLN
    static var pln124_45: Price {
        Price(amount: "124.45", currency: "PLN")
    }

    /// 123.45 PLN
    static var pln123_45: Price {
        Price(amount: "123.45", currency: "PLN")
    }
}
