// system
import Observation
import Foundation

import AliasWonderland
import Onion

struct MessagesFilterType: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let isChecked: Bool
}

@Observable 
class ThreadsViewModel {

    var searchFilterTextField: String = ""
    var showingFilterSearchPopup = false

    private(set) var threads: ListUserThreads = .empty
    private let messageCenter: MessageCenterRepository

    var filterTypes = [
        MessagesFilterType(title: "Nieprzeczytane", isChecked: false),
        MessagesFilterType(title: "Bez odpowiedzi", isChecked: false)
    ]

    init(
        messageCenter: MessageCenterRepository
    ) {
        self.messageCenter = messageCenter

        Task {
            self.threads = (try? await self.messageCenter.fetchThreads()) ?? .empty
        }
    }

}
