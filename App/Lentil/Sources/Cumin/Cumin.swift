// system
import Foundation

// local
import SecretsStore
import Onion

// 3rd party
import AliasWonderland

package var Cumin: CuminUseCases!

package final class CuminUseCases {

    package private(set) var auth: CuminUseCases.Auth
    package private(set) var secrets: SecretsStoreType
    package private(set) var secureStore: SecureStore
    private(set) var api: API

    init(
        auth: CuminUseCases.Auth,
        secrets: SecretsStoreType,
        secureStore: SecureStore,
        api: API
    ) {
        self.auth = auth
        self.secrets = secrets
        self.secureStore = secureStore
        self.api = api
    }
}

package extension CuminUseCases {
    static func prod(
        apiClient: APIClientType,
        secrets: SecretsStoreType
    ) -> Self {
        .init(
            auth: .prod,
            secrets: secrets,
            secureStore: .prod,
            api: API.prod(apiClient: apiClient)
        )
    }

    static var mock: CuminUseCases {
        .init(
            auth: .mock,
            secrets: MockSecureStore(),
            secureStore: .mock,
            api: .mock
        )
    }

    var apiClient: APIClientType {
        api.currentClient
    }
}

public extension Notification.Name {

    // Notification posted when a new token is fetched.
    static var hasNewToken: Self {
        .init(rawValue: "CuminUseCases.Auth.hasNewToken")
    }
}
