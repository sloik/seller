//system
import SwiftUI

// local
import Utilities
import Lettuce
import Acorn
import Onion

struct MainView: View {

    let acornFactory: AcornFactory

    var body: some View {
        TabView {
            Group {
                MessagesView()
                    .tabItem {
                        TabBarIcon(imageName: "messageTabIcon", titleName: "Wiadomości")
                    }
                MyOrdersView()
                    .tabItem {
                        TabBarIcon(imageName: "orderTabIcon", titleName: "Zamówienia")
                    }
                acornFactory.makeAccountView()
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
        acornFactory: .init(apiClient: MockApiClient())
    )
}
