
// system
import Foundation

// local
import Onion

struct Price: ContentType {
    let amount: String
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
