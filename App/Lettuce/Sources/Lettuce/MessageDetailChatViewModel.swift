// system
import SwiftUI
import Observation

// Local
import AliasWonderland
import Onion

@Observable class MessageDetailChatViewModel {

    var conversationMessage: String = ""
    let conversationLineLimit = 5

    private let networkingHandler: NetworkingHandlerType
    private let tokenProvider: Producer<String?>
    private var messages: [Message] = []
    private var thread: ListUserThreads.Thread

    init(
        networkingHandler: NetworkingHandlerType,
        tokenProvider: @escaping Producer<String?>,
        thread: ListUserThreads.Thread
    ) {
        self.networkingHandler = networkingHandler
        self.tokenProvider = tokenProvider
        self.thread = thread

        Task {
            self.messages = []
        }
    }
}
