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
    private(set) var api: API

    init(
        auth: CuminUseCases.Auth,
        secrets: SecretsStoreType,
        api: API
    ) {
        self.auth = auth
        self.secrets = secrets
        self.api = api
    }
}

package extension CuminUseCases {
    static var prod: CuminUseCases {
        .init(
            auth: .prod,
            secrets: ProductionSecretsStore(),
            api: .prod
        )
    }

    static var mock: CuminUseCases {
        .init(
            auth: .mock,
            secrets: MockSecureStore(),
            api: .mock
        )
    }
}
