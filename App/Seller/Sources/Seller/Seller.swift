
import Lentil
import SwiftUI
import OptionalAPI
import Onion

public final class Seller {

    public init() {
    }

    public func configure(
        using configuration: Configuration
    ) {
        LentilUseCases.configure(apiClient: configuration.apiClient)
    }

    public var body: some View {
        MainView()
    }
}

public extension Seller {
    struct Configuration {
        let apiClient: APIClientType

        public init(apiClient: APIClientType) {
            self.apiClient = apiClient
        }
    }

    var apiClient: APIClientType {
        Lentil.apiClient
    }
}
