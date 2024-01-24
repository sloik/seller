// system
import SwiftUI
import Observation

// Local
import AliasWonderland
import Onion

@Observable class MessageDetailChatViewModel {

    var conversationMessage: String = ""
    let conversationLineLimit = 5

    private var thread: ListUserThreads.Thread
    private let messageCenter: MessageCenterRepository

    private(set) var messages: MessagesInThread = .init(messages: [], offset: 0, limit: 0)

    init(
        thread: ListUserThreads.Thread,
        messageCenter: MessageCenterRepository
    ) {
        self.thread = thread
        self.messageCenter = messageCenter

        Task {
            self.messages = try await self.messageCenter.fetchMessages(thread)
        }
    }
}
