// system
import SwiftUI
import Observation

// Local
import AliasWonderland
import Onion

@Observable
final class MessageDetailChatModel: Sendable {

    private var thread: MessageCenterThread
    private let messageCenter: MessageCenterRepository

    var conversationMessage: String = ""
    let conversationLineLimit = 5

    var messages: [Message] {
        messageCenter.messages[thread]?.reversed() ?? []
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
}
