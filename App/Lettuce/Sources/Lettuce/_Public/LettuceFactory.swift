
import Foundation
import SwiftUI

import AliasWonderland
import Onion

public final class LettuceFactory {
    
    private let networkingHandler: NetworkingHandlerType
    private let tokenProvider: Producer<String?>

    public init(
        networkingHandler: NetworkingHandlerType,
        tokenProvider: @escaping Producer<String?>
    ) {
        self.networkingHandler = networkingHandler
        self.tokenProvider = tokenProvider
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
        .init(
            networkingHandler: networkingHandler,
            tokenProvider: tokenProvider
        )
    }

}
