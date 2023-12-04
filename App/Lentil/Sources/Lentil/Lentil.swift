// system
import Foundation
import SwiftUI

// local
import Cumin
import Yuca
import SecretsStore
import Onion

// 3rd party
import AliasWonderland

public private(set) var Lentil: LentilUseCases!

public struct LentilUseCases {

    public enum Env {
        case prod, mock
    }

    public static func configure(
        apiClient: APIClientType,
        secrets: SecretsStoreType
    ) {
        Cumin = .prod(apiClient: apiClient, secrets: secrets)
        YucaUseCases.takeOffYuca(cumin: Cumin)

        Lentil = .init()
    }

}

public extension LentilUseCases {

    var apiClient: APIClientType {
        Cumin.apiClient
    }

    var secrets: SecretsStoreType {
        Cumin.secrets
    }

    /// True when has user token.
    var hasUserToken: Bool {
        Cumin.auth.token.isNotNone
    }

    func loginUI(didLogin: @escaping Consumer<Error?>) -> some View {
        AuthenticationView(didLogin: didLogin)
    }

}
