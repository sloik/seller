
import SwiftUI

struct NetworkingApiClientChooser: View {

    let configurations: [NetworkingConfigurationView.Configuration] = [
        .init(name: "Production", url: ApiClientFactory.Environment.production.url, isActive: false),
        .init(name: "Sandbox", url: ApiClientFactory.Environment.sandbox.url, isActive: false),
        .init(name: "Custom", url: .none, isActive: false)
    ]

    var body: some View {
        List {

            ForEach(configurations, id: \.name) { configuration in
                NetworkingConfigurationView(configuration: configuration)
            }

        }
        .navigationTitle("🕸️ Networking Client")
    }
}



struct NetworkingConfigurationView: View {

    struct Configuration {
        let name: String
        let url: URL?
        let isActive: Bool
    }

    let configuration: Configuration

    var body: some View {

        HStack {
            Text(configuration.name)

            Text(configuration.url?.absoluteString ?? "-")

            if configuration.isActive {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }

        }

    }
}
