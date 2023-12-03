// system
import SwiftUI

import Lentil

struct MyAccountView: View {
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
                    .design(sheet: .regular)
                #endif
            }
        }
    }
}

#Preview {
    MyAccountView()
}
