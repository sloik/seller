// system
import SwiftUI
import Observation

// Local
import AliasWonderland
import Onion

@Observable class MessageDetailChatViewModel {

    private var thread: ListUserThreads.Thread
    private let messageCenter: MessageCenterRepository

    var conversationMessage: String = ""
    let conversationLineLimit = 5

    var messages: [Message] {
        messageCenter.messages[thread] ?? []
    }

    init(
        thread: ListUserThreads.Thread,
        messageCenter: MessageCenterRepository
    ) {
        self.thread = thread
        self.messageCenter = messageCenter
    }
}
