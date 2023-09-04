// system
import Foundation
import SwiftUI

// local
import Cumin
import Yuca
import SecretsStore

// 3rd party
import AliasWonderland

public private(set) var Lentil: LentilUseCases!

public struct LentilUseCases {

    public enum Env {
        case prod, mock
    }

    public static func start(env: Env) {
        switch env {
        case .prod:
            Cumin = .prod
            Yuca = .prod
        case .mock:
            Cumin = .mock
            Yuca = .mock
        }

        Lentil = .init()
    }

}

public extension LentilUseCases {

    var loginUI: some View {
        AuthenticationView()
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

