
import SwiftUI

import Seller

var CurrentSeller: Seller = .init()

@main
struct AlleSellerApp: App {

    #if DEBUG
    @State private var showsDebugView = false
    #endif

    init() {
        CurrentSeller.takeOff(env: .prod)
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
    }
}
