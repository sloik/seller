
import Foundation

/// mark enum as frozen

enum AppEnvironment: Hashable, Equatable {
    case production
    case sandbox
}

extension AppEnvironment: CustomStringConvertible {
    var description: String {
        switch self {
        case .production: return "Production"
        case .sandbox   : return "Sandbox"
        }
    }
}
