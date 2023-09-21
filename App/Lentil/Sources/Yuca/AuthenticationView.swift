// system
import Foundation
import AuthenticationServices
import SwiftUI
import WebKit

// local

// 3rd party
import AliasWonderland
import OptionalAPI
import SweetBool

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

                    guard self.showError.isFalse else { return }

                    enum E: Error {
                        case missingURL
                    }
                    
                    if let url {
                        
                        Task {
                            do {
                                try await Yuca.cumin.auth.parseResultAndGetUserToken(from: url)
                            }
                            catch {
                                self.showedError = error
                                self.showError = true
                            }
                            
                        }
                    }
                    else {
                        self.showedError = E.missingURL
                        self.showError = true
                    }
                }
            }
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(String(describing: showedError!)),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(for: String.self) { _ in
               // NextView()
            }
            .navigationTitle("Login...")
        }
    }
}


