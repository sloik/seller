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
        apiClient: APIClientType
    ) {
        Cumin = .prod(apiClient: apiClient)
        YucaUseCases.takeOffYuca(cumin: Cumin)

        Lentil = .init()
    }

}

public extension LentilUseCases {

    var apiClient: APIClientType {
        Cumin.apiClient
    }

    func loginUI(didLogin: @escaping Consumer<Error?>) -> some View {
        AuthenticationView(didLogin: didLogin)
    }

}

// MARK: - Implementation details

//public func takeOffLentil() {
//    Lentil = .prod
//}
//
//public extension LentilUseCases {
//
//    static var prod: LentilUseCases {
//        Cumin = .prod
//    }
//}

// MARK: - Mock

public extension LentilUseCases {

//    static var mock: LentilUseCases {
//        Cumin = .mock
//    }
}

