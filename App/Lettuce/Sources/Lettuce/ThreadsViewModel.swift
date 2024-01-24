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

    private let networkingHandler: NetworkingHandlerType
    private let tokenProvider: Producer<String?>
    private(set) var threads: ListUserThreads = .empty

    var filterTypes = [
        MessagesFilterType(title: "Nieprzeczytane", isChecked: false),
        MessagesFilterType(title: "Bez odpowiedzi", isChecked: false)
    ]

    init(
        networkingHandler: NetworkingHandlerType,
        tokenProvider: @escaping Producer<String?>
    ) {
        self.networkingHandler = networkingHandler
        self.tokenProvider = tokenProvider

        Task {
            self.threads = (try? await self.fetchThreads()) ?? .empty
        }
    }

}


extension ThreadsViewModel {

    var token: String  {
        get throws {
            guard let token = tokenProvider() else {
                throw Errors.unableToGetToken
            }
            return token
        }
    }

    func fetchThreads() async throws -> ListUserThreads {
        let request = GetListUserThreads(token: try token)

        let (result, _) = try await networkingHandler.run(request)

        return result
    }
}
