
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
                apiClient: configuration.apiClient, 
                secrets: configuration.secrets
            )

        acornFactory = AcornFactory(
            apiClient: configuration.apiClient
        )
    }

    public var body: some View {
        MainView(acornFactory: self.acornFactory)
    }
}

public extension Seller {
    struct Configuration {
        let apiClient: APIClientType
        let secrets: SecretsStoreType

        public init(apiClient: APIClientType, secrets: SecretsStoreType) {
            self.apiClient = apiClient
            self.secrets = secrets
        }
    }

    var apiClient: APIClientType {
        Lentil.apiClient
    }

    var secrets: SecretsStoreType {
        Lentil.secrets
    }
}
