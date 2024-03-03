// system
import SwiftUI
import Observation

// Local
import AliasWonderland
import Onion
import Utilities

@Observable
final class MessageDetailChatModel: Sendable {

    private var thread: MessageCenterThread
    private let messageCenter: MessageCenterRepository

    var conversationMessage: String = ""
    let conversationLineLimit = 5

    var messages: SortedArray<Message> {
        messageCenter.messages[thread] ?? .empty
    }

    init(
        thread: MessageCenterThread,
        messageCenter: MessageCenterRepository
    ) {
        self.thread = thread
        self.messageCenter = messageCenter
    }
}

extension MessageDetailChatModel {

    func download(_ att: Attachment) async throws -> Data {
        try await messageCenter.download(att)
    }

    func sendMessageInThread() async {
        guard conversationMessage.isEmpty.isFalse else { return }

        try? await messageCenter.send(conversationMessage, threadId: thread.id)

        conversationMessage = ""
    }
}
