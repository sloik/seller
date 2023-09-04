// system
import Foundation

// local
import SecretsStore

// 3rd party
import AliasWonderland

package var Cumin: CuminUseCases!

package final class CuminUseCases {

    package private(set) var auth: CuminUseCases.Auth
    package private(set) var secrets: SecretsStoreType

    package init(
        auth: CuminUseCases.Auth,
        secrets: SecretsStoreType
    ) {
        self.auth = auth
        self.secrets = secrets
    }
}

package extension CuminUseCases {
    static var prod: CuminUseCases {
        .init(
            auth: .prod,
            secrets: ProductionSecretsStore()
        )
    }

    static var mock: CuminUseCases {
        .init(
            auth: .mock,
            secrets: MockSecureStore()
        )
    }
}
