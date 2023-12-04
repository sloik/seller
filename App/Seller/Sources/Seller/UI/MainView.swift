//system
import SwiftUI

// local
import Utilities
import Lettuce
import Acorn

struct MainView: View {

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
                MyAccountView()
                    .tabItem {
                        TabBarIcon(imageName: "accountTabIcon", titleName: "Konto")
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
