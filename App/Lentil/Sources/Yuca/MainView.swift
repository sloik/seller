//system
import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {
            Group {
//                MyOffersView()
//                    .tabItem {
//                        Label("Moje oferty", systemImage: "list.bullet")
//                    }
                   
//                MyTransactionsView()
//                    .tabItem {
//                        Label("Transakcje", systemImage: "dollarsign.square")
//                    }
                   
//                MessagesView()
//                    .tabItem {
//                        Label("Wiadomości", systemImage: "message")
//                    }
//
//                MySettingsView()
//                    .tabItem {
//                        Label("Ustawienia", systemImage: "slider.horizontal.3")
//                    }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
