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
            WebView(url: authenticationURL) { url in

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

// MARK: - Allegro Sandbox

private extension AuthenticationView {

    var usesSandboxClient: Bool {
        Yuca.cumin.apiClient.baseURL.absoluteString.contains( "sandbox" )
    }

    var baseAuthURL: URL { try! Yuca.cumin.secrets.authenticationURL }

    var sandboxAuthenticationURL: URL {
        var components = baseAuthURL.urlComponents!

        components.host = components
            .host!
            .replacingOccurrences(
                of: "allegro.pl",
                with: "allegro.pl.allegrosandbox.pl"
            )

        return components.url!
    }

    var authenticationURL: URL {
        usesSandboxClient ? sandboxAuthenticationURL : baseAuthURL
    }
}

