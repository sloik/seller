
import Foundation
import Observation

import AliasWonderland
import Collections
import HTTPTypes
import Onion
import OptionalAPI
import SweetBool
import Utilities
import Zippy

@Observable
final class MessageCenterRepository {

    private let networkingHandler: NetworkingHandlerType

    private(set) var messages: [MessageCenterThread: SortedArray<Message>] = [:]

    var threads: [MessageCenterThread] {
        messages.keys.sorted { lhs, rhs in
            Zippy.zip(lhs.lastMessageDateTime, rhs.lastMessageDateTime).map(>)
            ?? Zippy.zip(lhs.interlocutor?.login, rhs.interlocutor?.login).map(>)
            ?? (lhs.id > rhs.id)
        }
    }


    init(
        networkingHandler: NetworkingHandlerType
    ) {
        self.networkingHandler = networkingHandler
    }
}

// MARK: Errors

extension MessageCenterRepository {
    enum E: Error {
        case unableToCreateURL(from: String)
    }
}

// MARK: -

private extension MessageCenterRepository {

    func fetchMessages(threads: [MessageCenterThread]) async throws {

        let result: [MessageCenterThread : SortedArray<Message>] = try await withThrowingTaskGroup(
            of: (MessageCenterThread, MessagesInThread).self,
            returning: [MessageCenterThread: SortedArray<Message>].self
        ) { taskGroup in

            for thread in threads {
                taskGroup.addTask {
                    let msg = try await self.fetchMessages(thread)
                    return (thread, msg)
                }
            }

            var accumulator: [MessageCenterThread:  SortedArray<Message>] = [:]
            while let result = try await taskGroup.next() {
                var currentMessages = accumulator[result.0] ?? .empty

                for msg in result.1.messages {
                    currentMessages.insert(msg)
                }

                accumulator[result.0] = currentMessages
            }
            return accumulator
        }

        messages.merge(result) { _, new in new }
    }
}

// MARK: - Threads

extension MessageCenterRepository {

    func fetchThreads() async throws  {
        let request = GetListUserThreads()

        let (result, _) = try await networkingHandler.run(request)

        try await fetchMessages(threads: result.threads)
    }

    func markAsRead(_ thread: MessageCenterThread) async throws {
        let request = ChangeReadFlagOnThreadRequest(
            read: true,
            threadId: thread.id
        )

        let (result, _) = try await networkingHandler.run(request)

        try await update(result)
    }

    func markAsUnread(_ thread: MessageCenterThread) async throws {
        let request = ChangeReadFlagOnThreadRequest(
            read: false,
            threadId: thread.id
        )

        let (result, _) = try await networkingHandler.run(request)

        try await update(result)
    }

    /// Updates thread used as a key with the new value when it's different 
    /// from the existing one. Fetches all threads in any other case.
    private func update(_ thread: MessageCenterThread) async throws {

        if
            let existingThread = threads.first(where: { $0.id == thread.id }),
            existingThread != thread,
            let threadMessages = messages.removeValue(forKey: existingThread) {
            messages[thread] = threadMessages
        } else {
            try await fetchThreads()
        }
    }

}

// MARK: - Messages

extension MessageCenterRepository {

    private func fetchMessages(_ thread: MessageCenterThread) async throws -> MessagesInThread {
        let request = ListMessagesInThreadRequest(
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
            .map { (messages: SortedArray<Message>) in
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

    func download(_ att: Attachment) async throws -> Data {

        guard let attachmentId = att.attachmentId else {
            throw E.unableToCreateURL(from: att.urlString ?? "missing url")        }

        let request = DownloadAttachmentDataRequest(
            attachmentId: attachmentId.id
        )

        let (result, _) = try await networkingHandler.run(request)

        return result
    }

    func send(_ message: String, thread: MessageCenterThread) async throws {

        let body = PostMessageInThread.Body(
            text: message,
            attachments: .none
        )

        let request = PostMessageInThread(threadId: thread.id, body: body)

        let (result, _): (Message, HTTPResponse) = try await networkingHandler.run(request)

        if messages.keys.contains(thread) {
            messages[thread]?.insert(result)
        } else {
            messages[thread] = .init(unsorted: [result])
        }
    }

    func loadOlderMessages(_ thread: MessageCenterThread) async throws {

    }

}
