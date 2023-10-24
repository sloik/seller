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

    private var didLogin: Consumer<Error?>

    package init(
        didLogin: @escaping Consumer<Error?>
    ) {
        self.didLogin = didLogin
    }

    package var body: some View {
        VStack {
            WebView(url: try! Yuca.cumin.secrets.authenticationURL) { url in

                guard self.showError.isFalse else { return }

                enum E: Error {
                    case missingURL
                }

                if let url {

                    Task {
                        do {
                            try await Yuca.cumin.auth.parseResultAndGetUserToken(from: url) {
                                didLogin( nil )
                            }
                        }
                        catch {
                            self.showedError = error
                            self.showError = true
                        }
                    }
                }
                else {
                    // we are not loggein
                    self.showedError = E.missingURL
                    self.showError = true
                }
            }
        }
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(String(describing: showedError!)),
                dismissButton: .default(
                    Text("Ok"),
                    action: { didLogin( self.showedError ) }
                )
            )
        }
        .navigationTitle("Login...")
    }
}


