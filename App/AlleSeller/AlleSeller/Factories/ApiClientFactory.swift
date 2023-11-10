
import Foundation
import Onion

enum ApiClientFactory {

    enum Environment: Hashable, Equatable {        
        case production
        case sandbox
        case custom(URL)

        var isCustom: Bool {
            switch self {
            case .custom: 
                return true
            default:
                return false
            }
        }
    }

    static func makeApiClient(for environment: Environment) -> APIClientType {
        APIClient(baseURL: environment.url)
    }
}

extension ApiClientFactory.Environment {

    var name: String {
        switch self {
        case .production: return "Production"
        case .sandbox   : return "Sandbox"
        case .custom    : return "Custom"
        }
    }

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

