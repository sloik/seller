
// system
import SwiftUI
import Observation
import OSLog

// local
import SweetBool
import Onion

private let logger = Logger(subsystem: "Acorn", category: "MyAccountViewModel")

@Observable
final class MyAccountViewModel {

    enum State {
        case login, profile
    }

    private let loginHandler: LoginHandlerType
    private let networkingHandler: NetworkingHandlerType

    var visible: State = .login
    var user: User?

    /// Controls visibility of the login web view.
    var loginWebViewIsPresented = false {
        didSet {
            updateVisibility()
        }
    }

    init(
        loginHandler: LoginHandlerType,
        networkingHandler: NetworkingHandlerType
    ) {
        self.loginHandler = loginHandler
        self.networkingHandler = networkingHandler
        updateVisibility()
    }
}

// MARK: - View Interface

extension MyAccountViewModel {

    func didTapRefreshToken() {
        Task {
            try await loginHandler.refreshToken()
            updateVisibility()
        }
    }

    func didTapLogin() {
        loginWebView(show: true)
    }

    func didTapLogout() {
        logout()
    }

    func onAppear() {
        fetchUserData()
    }

    func opacity(for state: State) -> Double {
        state == visible ? 1 : 0
    }
}

// MARK: - UI State

private extension MyAccountViewModel {

    func loginWebView(show: Bool) {
        loginWebViewIsPresented = show
    }

    func updateVisibility() {
        visible = loginHandler.hasToken.biTransform(yes: .profile, no: .login)
    }
}

// MARK: - Login

extension MyAccountViewModel {
    func didLogin(_ error: Error?) {
        loginWebViewIsPresented = false
    }

    func logout() {
        loginHandler.logout()
        visible = .login
    }
}

// MARK: - User Data

private extension MyAccountViewModel {

    func fetchUserData() {
        Task {
            do {
                user = try await getUser()
            } catch {
                logger.info("Unable to get user data with error: \(error.localizedDescription)")

                user = .none
                visible = .login
            }
        }
    }

    func getUser() async throws -> User {

        enum GetUserError: Error {
            case missingToken
        }

        guard
            let token = loginHandler.token
        else {
            throw GetUserError.missingToken
        }

        let meRequest = MeRequest(token: token)

        let (user, _) = try await networkingHandler.run( meRequest )

        return user
    }
}
