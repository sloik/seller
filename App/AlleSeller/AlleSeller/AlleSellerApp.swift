
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
            apiClient: ApiClientFactory.makeApiClient(for: .production), 
            secrets: ProductionSecretsStore()
        )

        CurrentSeller.configure(using: configuration)
    }


    var body: some Scene {
        WindowGroup {
            CurrentSeller
                .body
            #if DEBUG
                .onShakeGesture {
                    showsDebugView.toggle()
                }
                .sheet(isPresented: $showsDebugView) {
                    DebugView()
                }
            #endif
        }
        .commands {
            #if DEBUG
            CommandMenu("Debug") {
                Button("Toggle Debug View") {
                    showsDebugView.toggle()
                }
                .keyboardShortcut("d", modifiers: [/*@START_MENU_TOKEN@*/.command/*@END_MENU_TOKEN@*/,.shift])
            }
            #endif
        }
    }
}
