
import Foundation

final class DebugNetworkingInfoProvider {
    var baseURL: URL {  CurrentSeller.apiClient.baseURL }

    var environment: ApiClientFactory.Environment {
        switch baseURL {
        case ApiClientFactory.Environment.production.url:
            return .production
        case ApiClientFactory.Environment.sandbox.url:
            return .sandbox
        default:
            return .custom(baseURL)
        }
    }
}
