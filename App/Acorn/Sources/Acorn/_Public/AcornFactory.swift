
import SwiftUI
import Onion
import Lentil

public final class AcornFactory {

    private let networkingHandler: NetworkingHandlerType

    public init(
        networkingHandler: NetworkingHandlerType
    ) {
        self.networkingHandler = networkingHandler
    }
}

// MARK: - Public

public extension AcornFactory {
    /// Main entry point view for user profile.
    func makeEntryView() -> some View {
        MyAccountView(model: myAccountViewModel)
    }
}

// MARK: - Internal

extension AcornFactory {

    var loginHandler: LoginHandlerType {
        Lentil
    }

    var myAccountViewModel: MyAccountViewModel {
        MyAccountViewModel(
            loginHandler: loginHandler,
            networkingHandler: networkingHandler
        )
    }

}
