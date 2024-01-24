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

    let messageCenter: MessageCenterRepository

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

}
