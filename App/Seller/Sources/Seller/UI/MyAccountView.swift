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
                    .design(sheet: .regular)
            }
        }
    }
}

#Preview {
    MyAccountView()
}
