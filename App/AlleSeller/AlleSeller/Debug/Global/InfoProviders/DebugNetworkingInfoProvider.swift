
import Foundation

import Seller

enum DebugNetworkingInfoProvider {
    static func environment(for seller: Seller) -> AppEnvironment {
        
        let baseURL = seller.authApiClient.baseURL

        switch baseURL {
        case AppEnvironment.production.authClientBaseURL:
            return .production
        case AppEnvironment.sandbox.authClientBaseURL:
            return .sandbox
        default:
            fatalError("Unknown base URL: \(baseURL)")
        }
    }
}
