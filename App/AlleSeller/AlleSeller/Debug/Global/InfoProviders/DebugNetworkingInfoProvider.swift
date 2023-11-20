
import Foundation

final class DebugNetworkingInfoProvider {
    var baseURL: URL {  CurrentSeller.apiClient.baseURL }

    var environment: AppEnvironment {
        switch baseURL {
        case AppEnvironment.production.apiClientBaseURL:
            return .production
        case AppEnvironment.sandbox.apiClientBaseURL:
            return .sandbox
        default:
            fatalError("Unknown base URL: \(baseURL)")
        }
    }
}
