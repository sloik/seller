
import SwiftUI
import Onion

public final class AcornFactory {

    private let apiClient: APIClientType

    public init(
        apiClient: APIClientType
    ) {
        self.apiClient = apiClient
    }
}

// MARK: - Public

public extension AcornFactory {
    /// Main entry point view for user profile.
    func makeAccountView() -> some View {
        MyAccountView(model: myAccountViewModel)
    }
}

// MARK: - Internal

extension AcornFactory {

    var myAccountViewModel: MyAccountViewModel {
        MyAccountViewModel()
    }

}
