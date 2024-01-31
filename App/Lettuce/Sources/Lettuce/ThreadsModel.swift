// system

import Combine
import Foundation
import Observation

import AliasWonderland
import Onion
import Zippy

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
        MessagesFilterType(title: "Nieprzeczytane", isChecked: false),
        MessagesFilterType(title: "Bez odpowiedzi", isChecked: false)
    ]

    init(
        messageCenter: MessageCenterRepository
    ) {
        self.messageCenter = messageCenter
    }

    func getAll() {
        Task {
            try? await self.messageCenter.fetchThreads()
        }
    }

    func markAsRead(_ thread: MessageCenterThread) {
        print(#function)
    }

    func markAsUnread(_ thread: MessageCenterThread) {
        print(#function)
    }

}
