
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
            .environment(\.messageCenter, messageCenter)
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

    var messageCenter: MessageCenterRepository {
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

// MARK: - Environment

// MARK: Message Center Repository

private struct MessageCenterKey: EnvironmentKey {

    static let defaultValue: MessageCenterRepository = .init(
        networkingHandler: MockNetworkingHandler(),
        tokenProvider: { nil }
    )
}

extension EnvironmentValues {
    var messageCenter: MessageCenterRepository {
        get { self[MessageCenterKey.self] }
        set { self[MessageCenterKey.self] = newValue }
    }
}
