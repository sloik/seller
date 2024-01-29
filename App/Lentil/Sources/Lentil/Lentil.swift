// system
import Foundation
import SwiftUI
import OSLog

// local
import Cumin
import Yuca
import SecretsStore
import Onion

// 3rd party
import AliasWonderland

public private(set) var Lentil: LentilUseCases!

private let logger = Logger(subsystem: "LentilUseCases", category: "Lentil")

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

    var userToken: String? {
        Cumin.auth.token
    }

    var userRefreshToken: String? {
        Cumin.auth.refreshToken
    }

    /// True when has user token.
    var hasUserToken: Bool {
        Cumin.auth.token.isNotNone
    }

}

// MARK: - Login

public extension LentilUseCases {

    func loginUI(didLogin: @escaping Consumer<Error?>) -> some View {
        AuthenticationView(didLogin: didLogin)
    }

    func logout() {
        logger.info("Logging out")

        Cumin.secureStore.delete(.token)
    }

    func refreshToken() async throws {
        logger.debug("\(type(of: self)) \(#function)>")
        try await Cumin.auth.fetchNewTokenUsingRefreshToken()
    }
}


extension LentilUseCases: LoginHandlerType {

    public var token: String? {
        userToken
    }
    
}

public extension Notification.Name {

    // Notification posted when a new token is fetched.
    static var hasNewToken: Self {
        .init(rawValue: "CuminUseCases.Auth.hasNewToken")
    }

}
