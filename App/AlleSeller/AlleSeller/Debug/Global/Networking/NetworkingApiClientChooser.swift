
import SwiftUI
import AliasWonderland
import Onion
import SweetBool
import SweetPredicate

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
                    let newApiClient = ApiClientFactory.makeApiClient(for: configuration.environment)
                    setCurrent(apiClient: newApiClient)
                }
            }

        }
        .navigationTitle("🕸️ Networking Client")
    }
}

private func setCurrent(apiClient: APIClientType) {
    print("🛤️", #function, apiClient.baseURL.absoluteString)
}
