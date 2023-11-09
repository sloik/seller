
import SwiftUI
import AliasWonderland

struct NetworkingApiClientChooser: View {

    let configurations: [NetworkingConfigurationView.Configuration] = [
        .init(name: "Production", url: ApiClientFactory.Environment.production.url, isActive: false),
        .init(name: "Sandbox", url: ApiClientFactory.Environment.sandbox.url, isActive: false),
        .init(name: "Custom", url: .none, isActive: false)
    ]

    var body: some View {
        List {

            ForEach(configurations, id: \.name) { configuration in
                NetworkingConfigurationView(configuration: configuration) {
                    print("Tapped \(configuration.name)")
                }
            }

        }
        .navigationTitle("🕸️ Networking Client")
    }
}
