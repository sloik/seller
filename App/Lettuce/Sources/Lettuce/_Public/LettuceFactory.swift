
import Foundation
import SwiftUI
import Observation

import AliasWonderland
import Onion

@Observable
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
        ThreadsView(model: myMessagesViewModel)
            .environment(self)
    }
}

// MARK: - Internal

extension LettuceFactory {

    var myMessagesViewModel: ThreadsViewModel {
        .init(
            networkingHandler: networkingHandler,
            tokenProvider: tokenProvider
        )
    }

    func detailChatViewModel(
        thread: ListUserThreads.Thread
    ) -> MessageDetailChatViewModel {
        .init(
            networkingHandler: networkingHandler,
            tokenProvider: tokenProvider,
            thread: thread
        )
    }

}
