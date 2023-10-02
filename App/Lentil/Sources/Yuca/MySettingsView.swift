// system
import SwiftUI

struct MySettingsView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Button {
                path.append("AuthenticationView")
            } label: {
                Text("Log in")
            }
            .navigationDestination(for: String.self) { view in
                if view == "AuthenticationView" {
                    AuthenticationView()
                }
            }
        }
    }
}

#Preview {
    MySettingsView()
}