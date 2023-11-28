//system
import SwiftUI

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
    
    private struct TabBarIcon: View {
        private let imageName: String
        private let titleName: String
        
        init(imageName: String, titleName: String) {
            self.imageName = imageName
            self.titleName = titleName
        }
        
        var body: some View {
            VStack(spacing: 0) {
                Image(imageName)
                    .padding(.bottom, 10)
                Text(titleName)
                    .design(typography: .label(weight: .regular, size: 12))
            }
        }
    }
}

#Preview {
    MainView()
}
