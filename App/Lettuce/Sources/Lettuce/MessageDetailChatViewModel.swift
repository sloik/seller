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
    private var thread: ListUserThreads.Thread

    private(set) var messages: MessagesInThread = .init(messages: [], offset: 0, limit: 0)

    init(
        networkingHandler: NetworkingHandlerType,
        tokenProvider: @escaping Producer<String?>,
        thread: ListUserThreads.Thread
    ) {
        self.networkingHandler = networkingHandler
        self.tokenProvider = tokenProvider
        self.thread = thread

        Task {
            self.messages = try await fetchMessages()
        }
    }
}

private extension MessageDetailChatViewModel {

    var token: String  {
        get throws {
            guard let token = tokenProvider() else {
                throw Errors.unableToGetToken
            }
            return token
        }
    }

    func fetchMessages() async throws -> MessagesInThread {
        let request = ListMessagesInThreadRequest(
            token: try token,
            threadId: thread.id
        )

        let (result, _) = try await networkingHandler.run(request)

        return result
    }
}
