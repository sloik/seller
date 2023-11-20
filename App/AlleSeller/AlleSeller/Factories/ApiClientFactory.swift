
import Foundation
import Onion

enum ApiClientFactory {
    static func makeApiClient(for environment: AppEnvironment) -> APIClientType {
        APIClient(baseURL: environment.apiClientBaseURL)
    }
}

extension AppEnvironment {
    var apiClientBaseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://allegro.pl")!
        case .sandbox:
            return URL(string: "https://allegro.pl.allegrosandbox.pl")!
        }
    }
}
