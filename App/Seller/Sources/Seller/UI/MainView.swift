//system
import Combine
import SwiftUI

// local
import Acorn
import Lentil
import Lettuce
import Onion
import Tomatos
import Utilities

struct MainView: View {

    let lettuceFactory: LettuceFactory
    let tomatosFactory: TomatosFactory
    let acornFactory: AcornFactory

    let didGotToken: AnyPublisher<Void,Never> = NotificationCenter.default.publisher(for: .hasNewToken).map { _ in  }.eraseToAnyPublisher()

    var body: some View {
        TabView {
            Group {
                lettuceFactory.makeEntryView(refresh: didGotToken)
                    .tabItem {
                        TabBarIcon(imageName: "messageTabIcon", titleName: "Wiadomości")
                    }
                tomatosFactory.makeEntryView()
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
        lettuceFactory: LettuceFactory.takeOff(
            networkingHandler: MockNetworkingHandler()
        ),
        tomatosFactory: TomatosFactory(
            networkingHandler: MockNetworkingHandler()
        ),
        acornFactory: .init(
            networkingHandler: MockNetworkingHandler()
        )
    )
}
