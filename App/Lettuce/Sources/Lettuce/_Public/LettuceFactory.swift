
import Foundation
import SwiftUI

import Onion

public final class LettuceFactory {
    
    private let networkingHandler: NetworkingHandlerType

    public init(
        networkingHandler: NetworkingHandlerType
    ) {
        self.networkingHandler = networkingHandler
    }
}

// MARK: - Public

public extension LettuceFactory {
    /// Main entry point for the module.
    func makeEntryView() -> some View {
        MessagesView(model: myMessagesViewModel)
    }
}

// MARK: - Internal

extension LettuceFactory {

    var myMessagesViewModel: MyMessagesViewModel {
        .init(networkingHandler: networkingHandler)
    }

}
