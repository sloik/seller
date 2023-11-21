
import Foundation

enum DebugNetworkingInfoProvider {
    static var baseURL: URL {  CurrentSeller.apiClient.baseURL }

    static var environment: AppEnvironment {
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
