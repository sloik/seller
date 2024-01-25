
import Foundation
import SwiftUI
import Observation

import AliasWonderland
import Onion

@Observable
public final class LettuceFactory {

    private let networkingHandler: NetworkingHandlerType
    private let tokenProvider: Producer<String?>

    let messageCenter: MessageCenterRepository

    static var shared: LettuceFactory!

    public static func takeOff(
        networkingHandler: NetworkingHandlerType,
        tokenProvider: @escaping Producer<String?>
    ) -> LettuceFactory {
        LettuceFactory.shared = .init(networkingHandler: networkingHandler, tokenProvider: tokenProvider)

        return LettuceFactory.shared
    }

    private init(
        networkingHandler: NetworkingHandlerType,
        tokenProvider: @escaping Producer<String?>
    ) {
        self.networkingHandler = networkingHandler
        self.tokenProvider = tokenProvider

        self.messageCenter = .init(
            networkingHandler: networkingHandler,
            tokenProvider: tokenProvider
        )
    }
}

// MARK: - Public

public extension LettuceFactory {
    /// Main entry point for the module.
    func makeEntryView() -> some View {
        ThreadsView(model: myMessagesViewModel)
            .environment(LettuceFactory.shared)
            .environment(messageCenter)
    }
}

// MARK: - Internal

extension LettuceFactory {

    var myMessagesViewModel: ThreadsViewModel {
        .init(
            messageCenter: messageCenter
        )
    }

    func detailChatViewModel(
        thread: MessageCenterThread
    ) -> MessageDetailChatViewModel {
        .init(
            thread: thread, 
            messageCenter: messageCenter
        )
    }

}
