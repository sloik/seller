//system
import Combine
import SwiftUI

// local
import Acorn
import Lentil
import Lettuce
import Onion
import Utilities

struct MainView: View {

    let acornFactory: AcornFactory
    let lettuceFactory: LettuceFactory

    let didGotToken: AnyPublisher<Void,Never> = NotificationCenter.default.publisher(for: .hasNewToken).map { _ in  }.eraseToAnyPublisher()

    var body: some View {
        TabView {
            Group {
                lettuceFactory.makeEntryView(refresh: didGotToken)
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
        lettuceFactory: LettuceFactory.takeOff(
            networkingHandler: MockNetworkingHandler(),
            tokenProvider: { "token" }
        )
    )
}
