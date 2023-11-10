
import SwiftUI
import AliasWonderland
import Onion
import SweetBool
import SweetPredicate

struct NetworkingApiClientChooser: View {

    @State var configurations: [NetworkingConfigurationView.Configuration] = []

    var body: some View {
        List {
            ForEach(configurations, id: \.environment) { configuration in
                NetworkingConfigurationView(configuration: configuration) {
                    let newApiClient = ApiClientFactory.makeApiClient(for: configuration.environment)
                    setCurrent(apiClient: newApiClient)
                    refreshConfiguration()
                }
            }

            if configurationContainsCustom.isFalse {
                Text("TODO: add a way to inject custom URL string")
            }
        }
        .navigationTitle("🕸️ Networking Client")
        .onAppear {
            refreshConfiguration()
        }
    }

    private var baseURL: URL {  CurrentSeller.apiClient.baseURL }

    private var environment: ApiClientFactory.Environment {
        switch baseURL {
        case ApiClientFactory.Environment.production.url:
            return .production
        case ApiClientFactory.Environment.sandbox.url:
            return .sandbox
        default:
            return .custom(baseURL)
        }
    }

    var configurationContainsCustom: Bool {
        configurations
            .map(\.environment)
            .contains(where: \.isCustom)
    }

    private func refreshConfiguration() {
        configurations = [
            .init(environment: .production, isActive: environment == .production ),
            .init(environment: .sandbox, isActive: environment == .sandbox),
        ]

        configurations
            .map(\.isActive)
            .allSatisfy( \.isFalse )
            .whenTrue {
                configurations
                    .append(
                        .init(
                            environment: .custom(baseURL),
                            isActive: true
                        )
                    )
            }

    }
}

private func setCurrent(apiClient: APIClientType) {
    CurrentSeller.configure(
        using: .init(apiClient: apiClient)
    )
}
