
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

// MARK: -

private extension MessageCenterRepository {
    var token: String  {
        get throws {
            guard let token = tokenProvider() else {
                throw Errors.unableToGetToken
            }
            return token
        }
    }

    func fetchMessagesForThreads() async throws {
        let result = try await withThrowingTaskGroup(
            of: (ListUserThreads.Thread, MessagesInThread).self,
            returning: [ListUserThreads.Thread: [Message]].self
        ) { taskGroup in

            for thread in threads {
                taskGroup.addTask {
                    let msg = try await self.fetchMessages(thread)
                    return (thread, msg)
                }

            }

            var accumulator: [ListUserThreads.Thread:  [Message]] = [:]
            while let result = try await taskGroup.next() {
                accumulator[result.0] = result.1.messages
            }
            return accumulator
        }

        messages.merge(result) { _, new in new }
    }
}

// MARK: - Threads

extension MessageCenterRepository {

    func fetchThreads() async throws  {
        let request = GetListUserThreads(token: try token)

        let (result, _) = try await networkingHandler.run(request)

        self.threads = result.threads

        try await fetchMessagesForThreads()
    }
}

// MARK: - Messages

extension MessageCenterRepository {

    private func fetchMessages(_ thread: ListUserThreads.Thread) async throws -> MessagesInThread {
        let request = ListMessagesInThreadRequest(
            token: try token,
            threadId: thread.id
        )

        let (result, _) = try await networkingHandler.run(request)

        return result
    }

    func messagesCount(_ thread: ListUserThreads.Thread) -> Int {
        messages[thread]
            .map { messages in
                messages.count
            }
            .or( .zero )
    }
}

// MARK: - Attachments

extension MessageCenterRepository {

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
