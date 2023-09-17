// system
import Foundation
import AuthenticationServices
import SwiftUI
import WebKit

// local

// 3rd party
import AliasWonderland
import OptionalAPI

package struct AuthenticationView: View {

    @Environment(\.webAuthenticationSession)
    var session

    @State var showError: Bool = false
    @State var showedError: Error? = nil

    @State private var navPath = NavigationPath()

    package init() {}

    package var body: some View {

        NavigationStack(path: $navPath) {
            VStack {

                WebView(url: try! Yuca.cumin.secrets.authenticationURL) { url in
                    print("🛤️", url as Any)
                }
            }
            .navigationDestination(for: String.self) { _ in
               // NextView()
            }
            .navigationTitle("Login...")
        }
    }
}


