
import SwiftUI

extension DebugView {

    struct NetworkingRow: View {

        let title: String
        @Binding var currentEnvironment: AppEnvironment

        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Text(currentEnvironment.description)
            }
        }
    }

}
