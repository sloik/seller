
import Foundation
import Observation

import AliasWonderland
import Onion
import SweetBool
import OptionalAPI
import Zippy

@Observable
final class MessageCenterRepository {

    private let networkingHandler: NetworkingHandlerType
    private let tokenProvider: Producer<String?>

    private(set) var messages: [MessageCenterThread:  [Message]] = [:]

    var threads: [MessageCenterThread] {
        messages.keys.sorted { lhs, rhs in
            Zippy.zip(lhs.lastMessageDateTime, rhs.lastMessageDateTime).map(>)
            ?? Zippy.zip(lhs.interlocutor?.login, rhs.interlocutor?.login).map(>)
            ?? (lhs.id > rhs.id)
        }
    }


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

    func fetchMessages(threads: [MessageCenterThread]) async throws {
        let result = try await withThrowingTaskGroup(
            of: (MessageCenterThread, MessagesInThread).self,
            returning: [MessageCenterThread: [Message]].self
        ) { taskGroup in

            for thread in threads {
                taskGroup.addTask {
                    let msg = try await self.fetchMessages(thread)
                    return (thread, msg)
                }

            }

            var accumulator: [MessageCenterThread:  [Message]] = [:]
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

        try await fetchMessages(threads: result.threads)
    }
}

// MARK: - Messages

extension MessageCenterRepository {

    private func fetchMessages(_ thread: MessageCenterThread) async throws -> MessagesInThread {
        let request = ListMessagesInThreadRequest(
            token: try token,
            threadId: thread.id
        )

        let (result, _) = try await networkingHandler.run(request)

        return result
    }

    func messagesCount(_ thread: MessageCenterThread) -> Int {
        messages[thread]
            .map { messages in
                messages.count
            }
            .or( .zero )
    }

    func lastMessage(_ thread: MessageCenterThread) -> Message? {
        messages[thread]
            .map { messages in
                messages.last
            }
            .or( .none )
    }
}

// MARK: - Attachments

extension MessageCenterRepository {

    func hasAttachments(_ thread: MessageCenterThread) -> Bool {
        messages[thread]
            .map { (messages: [Message]) in
                messages
                    .contains { (message: Message) in
                        message.hasAdditionalAttachments || message.attachments.isEmpty.isFalse
                    }
            }
            .or( false )
    }

    func attachmentsCount(_ thread: MessageCenterThread) -> Int {
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
