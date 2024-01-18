// system
import Observation
import Foundation
import Onion

struct MessagesFilterType: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let isChecked: Bool
}

@Observable 
class MyMessagesViewModel {

    var searchFilterTextField: String = ""
    var showingFilterSearchPopup = false

    private let networkingHandler: NetworkingHandlerType

    private(set) var threads: ListUserThreads = .empty

    var filterTypes = [
        MessagesFilterType(title: "Nieprzeczytane", isChecked: false),
        MessagesFilterType(title: "Bez odpowiedzi", isChecked: false)
    ]

    init(
        networkingHandler: NetworkingHandlerType
    ) {
        self.networkingHandler = networkingHandler

        Task {
            self.threads = await self.fetchMessages()
        }
    }

}


extension MyMessagesViewModel {

    func fetchMessages() async -> ListUserThreads {
        return .mock
    }
}
