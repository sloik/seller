
import SwiftUI
import AliasWonderland
import Onion

struct NetworkingApiClientChooser: View {

    let configurations: [NetworkingConfigurationView.Configuration] = [
        .init(environment: .production, isActive: false),
        .init(environment: .sandbox, isActive: false),
        .init(environment: .custom( URL(string: "www.fake.url")! ), isActive: false)
    ]

    var body: some View {
        List {

            ForEach(configurations, id: \.environment) { configuration in
                NetworkingConfigurationView(configuration: configuration) {
                    print("Tapped \(configuration.environment.name)")
                }
            }

        }
        .navigationTitle("🕸️ Networking Client")
    }
}

private func setCurrent(apiClient: APIClientType) {

}
