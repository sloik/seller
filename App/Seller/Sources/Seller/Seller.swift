
import Lentil
import SwiftUI
import OptionalAPI
import Onion
import SecretsStore
import Acorn

public final class Seller {

    private var acornFactory: AcornFactory!

    public init() {
    }

    public func configure(
        using configuration: Configuration
    ) {
        LentilUseCases
            .configure(
                apiClient: configuration.authApiClient, 
                secrets: configuration.secrets
            )

        acornFactory = AcornFactory(
            apiClient: configuration.restApiClient
        )
    }

    public var body: some View {
        MainView(acornFactory: self.acornFactory)
    }
}

public extension Seller {
    struct Configuration {
        /// Client used for token related requests.
        let authApiClient: APIClientType

        /// Client used for REST API.
        let restApiClient: APIClientType

        let secrets: SecretsStoreType

        public init(
            authApiClient: APIClientType,
            restApiClient: APIClientType,
            secrets: SecretsStoreType
        ) {
            self.authApiClient = authApiClient
            self.restApiClient = restApiClient
            self.secrets = secrets
        }
    }

    var authApiClient: APIClientType {
        Lentil.apiClient
    }

    var secrets: SecretsStoreType {
        Lentil.secrets
    }
}
