
import SwiftUI

import Onion

public final class TomatosFactory {

    private let networkingHandler: NetworkingHandlerType

    public init(
        networkingHandler: NetworkingHandlerType
    ) {
        self.networkingHandler = networkingHandler
    }
}

// MARK: - Public

public extension TomatosFactory {
    /// Main entry point view for user profile.
    func makeEntryView() -> some View {
        MyOrdersView()
    }
}

// MARK: - Internal

extension TomatosFactory {
}
