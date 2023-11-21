
import SwiftUI
import AliasWonderland
import Onion
import SweetBool
import SweetPredicate
import SecretsStore

struct NetworkingApiClientChooser: View {

    @State var configurations: [NetworkingConfigurationView.Configuration] = []
    @Binding var currentEnv: AppEnvironment

    var body: some View {
        List {
            ForEach(configurations, id: \.environment) { configuration in
                NetworkingConfigurationView(configuration: configuration) {
                    currentEnv = configuration.environment
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
        configurations = [
            .init(environment: .production, isActive: currentEnv == .production ),
            .init(environment: .sandbox, isActive: currentEnv == .sandbox),
        ]
    }
}
