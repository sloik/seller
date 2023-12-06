
import Foundation
import Onion

enum ApiClientFactory {
    static func makeAuthApiClient(for environment: AppEnvironment) -> APIClientType {
        APIClient(baseURL: environment.authClientBaseURL)
    }

    static func makeRestApiClient(for environment: AppEnvironment) -> APIClientType {
        APIClient(baseURL: environment.restApiClientBaseURL)
    }
}

extension AppEnvironment {
    var authClientBaseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://allegro.pl")!
        case .sandbox:
            return URL(string: "https://allegro.pl.allegrosandbox.pl")!
        }
    }

    var restApiClientBaseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://api.allegro.pl")!
        case .sandbox:
            return URL(string: "https://api.allegro.pl.allegrosandbox.pl")!
        }
    }
}
