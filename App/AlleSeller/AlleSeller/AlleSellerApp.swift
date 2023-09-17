
import SwiftUI

import Seller

@main
struct AlleSellerApp: App {

    var seller: Seller

    init() {
        self.seller = .init()
        self.seller.takeOff()
    }


    var body: some Scene {
        WindowGroup {
            seller.body
        }
    }
}
