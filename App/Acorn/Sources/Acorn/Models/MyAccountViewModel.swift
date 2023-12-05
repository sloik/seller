
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

    /// Controls visibility of the login web view.
    var loginWebViewIsPresented = false {
        didSet {
            updateVisibility()
        }
    }

    init() {
        updateVisibility()
    }
}

// MARK: - User Interaction

extension MyAccountViewModel {

    func didTapLogin() {
        loginWebViewIsPresented = true
    }

    func didTapLogout() {
        logout()
    }
}

// MARK: - UI State

extension MyAccountViewModel {

    func updateVisibility() {
        visible = Lentil.hasUserToken.biTransform(yes: .profile, no: .login)
    }

    func opacity(for state: State) -> Double {
        state == visible ? 1 : 0
    }
}

// MARK: - Login

extension MyAccountViewModel {
    func didLogin(_ error: Error?) {
        loginWebViewIsPresented = false
    }

    func logout() {
        Lentil.logout()
        visible = .login
    }
}
