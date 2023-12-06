
import Foundation
import Observation

@Observable
final class DebugFeaturesModel {

    /// Controls API client and secrets.
    var appEnvironment: AppEnvironment {
        didSet {
            updateAppEnvironment()
        }
    }

    init() {
        // Uses networking to check which environment is set
        self.appEnvironment = DebugNetworkingInfoProvider.environment
    }

    private func updateAppEnvironment() {
        let newAuthClient = ApiClientFactory.makeAuthApiClient(for: appEnvironment)
        let newApiClient = ApiClientFactory.makeRestApiClient(for: appEnvironment)
        let newSecrets = SecretsStoreFactory.makeStore(for: appEnvironment)

        CurrentSeller.configure(
            using: .init(
                authApiClient: newAuthClient,
                apiClient: newApiClient,
                secrets: newSecrets
            )
        )
    }
}
