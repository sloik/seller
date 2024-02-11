
import Foundation
import SwiftUI

import Seller
import Onion

@main
struct AlleSellerApp: App {

    #if DEBUG
    @State private var showsDebugView = false
    #endif

    let seller: Seller

    init() {
        let configuration = Seller.Configuration(
            authApiClient: ApiClientFactory.makeAuthApiClient(for: .production), 
            restApiClient: ApiClientFactory.makeRestApiClient(for: .production),
            secrets: ProductionSecretsStore()
        )

        seller = Seller()
        seller.configure(using: configuration)
    }


    var body: some Scene {
        WindowGroup {
            seller
                .body
                #if os(macOS)
                .design(minFrame: .window)
                #endif
            #if DEBUG
                .onShakeGesture {
                    showsDebugView.toggle()
                }
                .sheet(isPresented: $showsDebugView) {
                    DebugView(seller: seller)
                }
            #endif
        }

        #if os(macOS) && DEBUG
        Settings {
            DebugView(seller: seller)
        }
        #endif
    }
}
