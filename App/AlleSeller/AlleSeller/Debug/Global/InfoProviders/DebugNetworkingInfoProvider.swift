
import Foundation

enum DebugNetworkingInfoProvider {
    static var baseURL: URL {  CurrentSeller.authApiClient.baseURL }

    static var environment: AppEnvironment {
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
