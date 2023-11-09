
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



struct NetworkingConfigurationView: View {

    struct Configuration {
        let name: String
        let url: URL?
        let isActive: Bool
    }

    let configuration: Configuration

    let action: SideEffectClosure

    var body: some View {

        Button(action: action) {
            HStack {
                Text(configuration.name)

                Text(configuration.url?.absoluteString ?? "-")

                Spacer()

                if configuration.isActive {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())

        }
        .buttonStyle( PlainButtonStyle() )
    }
}

#Preview {

    NetworkingConfigurationView(
        configuration: .init(name: "Name", url: .none, isActive: true),
        action: {}
    )
    .previewLayout(.sizeThatFits)

}
