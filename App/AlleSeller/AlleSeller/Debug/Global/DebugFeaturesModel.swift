
import Foundation
import Observation

import Seller

@Observable
final class DebugFeaturesModel {

    /// Controls API client and secrets.
    var appEnvironment: AppEnvironment {
        didSet {
            updateAppEnvironment()
        }
    }

    let seller: Seller

    init(seller: Seller) {
        self.seller = seller
        // Uses networking to check which environment is set
        self.appEnvironment = DebugNetworkingInfoProvider.environment(for: seller)
    }

    private func updateAppEnvironment() {
        let newAuthClient = ApiClientFactory.makeAuthApiClient(for: appEnvironment)
        let newApiClient = ApiClientFactory.makeRestApiClient(for: appEnvironment)
        let newSecrets = SecretsStoreFactory.makeStore(for: appEnvironment)

        seller.configure(
            using: .init(
                authApiClient: newAuthClient,
                restApiClient: newApiClient,
                secrets: newSecrets
            )
        )
    }
}
