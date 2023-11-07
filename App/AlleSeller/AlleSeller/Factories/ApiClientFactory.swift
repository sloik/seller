
import Foundation
import Onion

enum ApiClientFactory {

    enum Environment {        
        case production
        case sandbox
        case custom(URL)
    }

    static func makeApiClient(for environment: Environment) -> APIClientType {
        APIClient(baseURL: environment.url)
    }
}

extension ApiClientFactory.Environment {

    var url: URL {
        switch self {

        case .production:
            return URL(string: "https://allegro.pl")!
        case .sandbox:
            return URL(string: "https://allegro.pl.allegrosandbox.pl")!
        case .custom(let url):
            return url
        }
    }
}

