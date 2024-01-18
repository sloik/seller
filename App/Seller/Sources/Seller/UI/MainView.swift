//system
import SwiftUI

// local
import Acorn
import Lettuce
import Onion
import Utilities

struct MainView: View {

    let acornFactory: AcornFactory
    let lettuceFactory: LettuceFactory

    var body: some View {
        TabView {
            Group {
                lettuceFactory.makeEntryView()
                    .tabItem {
                        TabBarIcon(imageName: "messageTabIcon", titleName: "Wiadomości")
                    }
                MyOrdersView()
                    .tabItem {
                        TabBarIcon(imageName: "orderTabIcon", titleName: "Zamówienia")
                    }
                acornFactory.makeEntryView()
                    .tabItem {
                        TabBarIcon(imageName: "accountTabIcon", titleName: "Konto")
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {

    MainView(
        acornFactory: .init(networkingHandler: MockNetworkingHandler()),
        lettuceFactory: .init(networkingHandler: MockNetworkingHandler())
    )
}
