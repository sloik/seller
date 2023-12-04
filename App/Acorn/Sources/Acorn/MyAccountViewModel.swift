
// system
import SwiftUI
import Observation

// local
import Lentil
import SweetBool


@Observable
final class MyAccountViewModel {

    enum State {
        case login, profile
    }

    var visible: State = .login

    var path = NavigationPath()

    /// Controls visibility of the login web view.
    var loginWebViewIsPresented = false {
        didSet {
            visible = Lentil.hasUserToken.biTransform(yes: .profile, no: .login)
        }
    }


    init() {
        visible = Lentil.hasUserToken.biTransform(yes: .profile, no: .login)
    }

    func didLogin(_ error: Error?) {
        loginWebViewIsPresented = false
    }

    func opacity(for state: State) -> Double {
        state == visible ? 1 : 0
    }
}

// MARK: - User Interaction

extension MyAccountViewModel {

    func didTapLogin() {
        loginWebViewIsPresented = true
    }

    func logout() {
        Lentil.logout()
        visible = .login
    }

}
