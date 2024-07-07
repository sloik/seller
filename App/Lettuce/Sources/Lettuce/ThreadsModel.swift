// system

import Combine
import Foundation
import OSLog
import Observation

import AliasWonderland
import Onion
import Zippy

private let logger = Logger(subsystem: "Lettuce", category: "ThreadsModel")

struct MessagesFilterType: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let isChecked: Bool
}

@Observable
class ThreadsModel {

    var searchFilterTextField: String = ""
    var showingFilterSearchPopup = false

    private var refreshCancelable: AnyCancellable?

    var refresh: AnyPublisher<Void,Never>? {
        didSet {
            refreshCancelable = refresh?
                .sink { [weak self] in
                self?.getAll()
            }
        }
    }

    private let messageCenter: MessageCenterRepository

    var threads: [MessageCenterThread] {
        messageCenter.threads
    }

    var filterTypes = [
        MessagesFilterType(title: String.localized("unread"), isChecked: false),
        MessagesFilterType(title: String.localized("unanswered"), isChecked: false)
    ]

    init(
        messageCenter: MessageCenterRepository
    ) {
        self.messageCenter = messageCenter
    }

    func getAll() {
        Task {
            do {
                try await self.messageCenter.fetchThreads()
            } catch {
                logger.error("🛤️ \(#function) \(error)")
            }
        }
    }

    func markAsRead(_ thread: MessageCenterThread) {
        Task {
            do {
                try await self.messageCenter.markAsRead(thread)
            } catch {
                logger.error("🛤️ \(#function) \(error)")
            }
        }
    }

    func markAsUnread(_ thread: MessageCenterThread) {
        Task {
            do {
                try await self.messageCenter.markAsUnread(thread)
            } catch {
                logger.error("🛤️ \(#function) \(error)")
            }
        }
    }

}
