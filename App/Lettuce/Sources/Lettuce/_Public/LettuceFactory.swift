
import Combine
import Foundation
import Observation
import SwiftUI

import AliasWonderland
import Onion

@Observable
public final class LettuceFactory {

    private let networkingHandler: NetworkingHandlerType

    let messageCenter: MessageCenterRepository

    static var shared: LettuceFactory!

    public static func takeOff(
        networkingHandler: NetworkingHandlerType
    ) -> LettuceFactory {
        LettuceFactory.shared = .init(networkingHandler: networkingHandler)

        return LettuceFactory.shared
    }

    private init(
        networkingHandler: NetworkingHandlerType
    ) {
        self.networkingHandler = networkingHandler

        self.messageCenter = .init(
            networkingHandler: networkingHandler
        )
    }
}

// MARK: - Public

public extension LettuceFactory {
    /// Main entry point for the module.
    func makeEntryView(refresh: AnyPublisher<Void,Never>) -> some View {

        let model = threadsModel
        model.refresh = refresh

        return ThreadsView(model: model)
            .environment(LettuceFactory.shared)
            .environment(messageCenter)
    }
}

// MARK: - Internal

extension LettuceFactory {

    var threadsModel: ThreadsModel {
        .init(
            messageCenter: messageCenter
        )
    }

    func detailChatModel(
        thread: MessageCenterThread
    ) -> MessageDetailChatModel {
        .init(
            thread: thread, 
            messageCenter: messageCenter
        )
    }

}
