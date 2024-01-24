
import Foundation
import Observation

import AliasWonderland
import Onion

@Observable
final class MessageCenterRepository {

    private let networkingHandler: NetworkingHandlerType
    private let tokenProvider: Producer<String?>

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

        return result
    }

    func fetchThreads() async throws -> ListUserThreads {
        let request = GetListUserThreads(token: try token)

        let (result, _) = try await networkingHandler.run(request)

        return result
    }
}
