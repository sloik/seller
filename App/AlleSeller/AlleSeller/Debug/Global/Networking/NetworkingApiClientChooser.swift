
import SwiftUI
import AliasWonderland
import Onion
import SweetBool
import SweetPredicate
import SecretsStore

struct NetworkingApiClientChooser: View {

    @State var configurations: [NetworkingConfigurationView.Configuration] = []

    @Binding var currentEnv: AppEnvironment

    let infoProvider: DebugNetworkingInfoProvider

    var body: some View {
        List {
            ForEach(configurations, id: \.environment) { configuration in
                NetworkingConfigurationView(configuration: configuration) {
                    setCurrent(environment: configuration.environment)
                    refreshConfiguration()
                }
            }
        }
        .navigationTitle("🕸️ Networking Client")
        .onAppear {
            refreshConfiguration()
        }
    }

    private func refreshConfiguration() {

        currentEnv = infoProvider.environment

        configurations = [
            .init(environment: .production, isActive: currentEnv == .production ),
            .init(environment: .sandbox, isActive: currentEnv == .sandbox),
        ]
    }

    private func setCurrent(environment: AppEnvironment) {
        let newApiClient = ApiClientFactory.makeApiClient(for: environment)
        let newSecrets = SecretsStoreFactory.makeStore(for: environment)

        CurrentSeller.configure(
            using: .init(
                apiClient: newApiClient,
                secrets: newSecrets
            )
        )
    }
}
