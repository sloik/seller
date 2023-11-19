// system
import SwiftUI

import Lentil

struct MySettingsView: View {
    @State private var path = NavigationPath()

    @State private var showLoginFlow = false

    var body: some View {
        NavigationStack(path: $path) {

            Button("Login") {
                showLoginFlow = true
            }
            .sheet(isPresented: $showLoginFlow) {
                Lentil
                    .loginUI { _ in
                       showLoginFlow = false
                    }
                    #if os(macOS)
                    .frame(minWidth: 800, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity)
                    #endif
            }
        }
    }
}

#Preview {
    MySettingsView()
}
