
import SwiftUI

import AliasWonderland

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
