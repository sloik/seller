
import Foundation
import SecretsStore

enum SecretsStoreFactory {
    static func makeStore(for environment: AppEnvironment) -> SecretsStoreType {
        switch environment {
        case .production:
            ProductionSecretsStore()
        case .sandbox:
            SandboxSecretsStore()
        }
    }
}
