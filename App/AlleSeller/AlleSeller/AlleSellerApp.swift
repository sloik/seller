
import Foundation
import SwiftUI

import Seller
import Onion

let CurrentSeller: Seller = .init()

@main
struct AlleSellerApp: App {

    #if DEBUG
    @State private var showsDebugView = false
    #endif

    init() {
        let configuration = Seller.Configuration(
            authApiClient: ApiClientFactory.makeAuthApiClient(for: .production), 
            restApiClient: ApiClientFactory.makeRestApiClient(for: .production),
            secrets: ProductionSecretsStore()
        )

        CurrentSeller.configure(using: configuration)
    }


    var body: some Scene {
        WindowGroup {
            CurrentSeller
                .body
                #if os(macOS)
                .design(minFrame: .window)
                #endif
            #if DEBUG
                .onShakeGesture {
                    showsDebugView.toggle()
                }
                .sheet(isPresented: $showsDebugView) {
                    DebugView()
                }
            #endif
        }

        #if os(macOS) && DEBUG
        Settings {
            DebugView()
        }
        #endif
    }
}
