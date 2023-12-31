
import SwiftUI

import AliasWonderland

struct NetworkingConfigurationView: View {

    struct Configuration {
        let environment: AppEnvironment
        let isActive: Bool
    }

    let configuration: Configuration

    let action: SideEffectClosure

    var body: some View {

        Button(action: action) {

            HStack {
                VStack(alignment: .leading) {
                    Text(configuration.environment.description)

                    HStack {
                        Text(configuration.environment.authClientBaseURL.absoluteString)
                        Spacer()
                    }
                }

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
        configuration: .init(environment: .production, isActive: true),
        action: {}
    )
    .previewLayout(.sizeThatFits)

}
