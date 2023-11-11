
import SwiftUI
import AliasWonderland
import Onion
import SweetBool
import SweetPredicate

struct NetworkingApiClientChooser: View {

    @State var configurations: [NetworkingConfigurationView.Configuration] = []

    @Binding var currentEnv: ApiClientFactory.Environment

    let infoProvider: DebugNetworkingInfoProvider

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

    var configurationContainsCustom: Bool {
        configurations
            .map(\.environment)
            .contains(where: \.isCustom)
    }

    private func refreshConfiguration() {

        currentEnv = infoProvider.environment

        configurations = [
            .init(environment: .production, isActive: currentEnv == .production ),
            .init(environment: .sandbox, isActive: currentEnv == .sandbox),
        ]

        configurations
            .map(\.isActive)
            .allSatisfy( \.isFalse )
            .whenTrue {
                configurations
                    .append(
                        .init(
                            environment: .custom(infoProvider.baseURL),
                            isActive: true
                        )
                    )
            }
    }

    private func setCurrent(apiClient: APIClientType) {
        CurrentSeller.configure(
            using: .init(apiClient: apiClient)
        )
    }
}
