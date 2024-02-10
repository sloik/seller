// system
import Foundation
import HTTPTypes

// local
import Onion
import Utilities

struct GetListUserThreads: PaginatedRequest {
    typealias Output = ListUserThreads
    
    var path: String {
        "/messaging/threads"
            .appendToPath(items: paginationQueryItems)
    }
    
    var headerFields: HTTPFields = [
        HTTPField.Name.accept : .applicationVndAllegroV1Json
    ]

    var offset: UInt
    var limit: UInt
    
    internal init(
        limit: UInt = 20,
        offset: UInt = 0
    ) {
        self.limit = limit
        self.offset = offset
    }
}
