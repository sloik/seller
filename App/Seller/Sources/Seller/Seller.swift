
import Acorn
import Lentil
import Lettuce
import Onion
import OptionalAPI
import SecretsStore
import Tomatos

import SwiftUI

public final class Seller {

    private var acornFactory: AcornFactory!
    private var lettuceFactory: LettuceFactory!
    private var tomatosFactory: TomatosFactory!

    private var networkingHandler: NetworkingHandlerType!

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

        networkingHandler = NetworkingHandler(apiClient: configuration.restApiClient, loginHandler: Lentil)

        acornFactory = AcornFactory(
            networkingHandler: networkingHandler
        )

        lettuceFactory = LettuceFactory.takeOff(
            networkingHandler: networkingHandler
        )

        tomatosFactory = TomatosFactory(
            networkingHandler: networkingHandler
        )
    }

    public var body: some View {
        MainView(
            lettuceFactory: self.lettuceFactory,
            tomatosFactory: self.tomatosFactory,
            acornFactory: self.acornFactory
        )
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

    func refreshToken() async throws {
        try await Lentil.refreshToken()
    }
}
