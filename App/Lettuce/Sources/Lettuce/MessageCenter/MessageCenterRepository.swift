
import Foundation
import Observation

import AliasWonderland
import Onion
import SweetBool
import OptionalAPI

@Observable
final class MessageCenterRepository {

    private let networkingHandler: NetworkingHandlerType
    private let tokenProvider: Producer<String?>

    private(set) var threads: [ListUserThreads.Thread] = []
    private(set) var messages: [ListUserThreads.Thread:  [Message]] = [:]

    init(
        networkingHandler: NetworkingHandlerType,
        tokenProvider: @escaping Producer<String?>
    ) {
        self.networkingHandler = networkingHandler
        self.tokenProvider = tokenProvider
    }

}

extension MessageCenterRepository {
    var token: String  {
        get throws {
            guard let token = tokenProvider() else {
                throw Errors.unableToGetToken
            }
            return token
        }
    }

    func fetchMessages(_ thread: ListUserThreads.Thread) async throws -> MessagesInThread {
        let request = ListMessagesInThreadRequest(
            token: try token,
            threadId: thread.id
        )

        let (result, _) = try await networkingHandler.run(request)
        messages[thread] = result.messages

        return result
    }

    func fetchThreads() async throws  {
        let request = GetListUserThreads(token: try token)

        let (result, _) = try await networkingHandler.run(request)

        self.threads = result.threads
    }

    func hasAttachments(_ thread: ListUserThreads.Thread) -> Bool {
        messages[thread]
            .map { (messages: [Message]) in
                messages
                    .contains { (message: Message) in
                        message.hasAdditionalAttachments || message.attachments.isEmpty.isFalse
                    }
            }
            .or( false )
    }

    func messagesCount(_ thread: ListUserThreads.Thread) -> Int {
        messages[thread]
            .map { messages in
                messages.count
            }
            .or( .zero )
    }

    func attachmentsCount(_ thread: ListUserThreads.Thread) -> Int {
        messages[thread]
            .map { messages in
                messages
                    .reduce(0) { count, message in
                        count + message.attachments.count
                    }
            }
            .or( .zero )
    }
}
