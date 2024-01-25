// system
import SwiftUI
import Observation

// Local
import AliasWonderland
import Onion

@Observable class MessageDetailChatModel {

    private var thread: MessageCenterThread
    private let messageCenter: MessageCenterRepository

    var conversationMessage: String = ""
    let conversationLineLimit = 5

    var messages: [Message] {
        messageCenter.messages[thread] ?? []
    }

    init(
        thread: MessageCenterThread,
        messageCenter: MessageCenterRepository
    ) {
        self.thread = thread
        self.messageCenter = messageCenter
    }
}
