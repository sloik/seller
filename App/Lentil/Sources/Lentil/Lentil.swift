// system
import Foundation

// local
import Cumin
import Yuca
import SecretsStore

// 3rd party
import AliasWonderland

public private(set) var Lentil: LentilUseCases!

public struct LentilUseCases {
    var _cumin: CuminUseCases
    var _yuca: YucaUseCases
}

public extension LentilUseCases {

}

// MARK: - Implementation details

private func takeOffLentil() {
    Lentil = .prod
}

public extension LentilUseCases {

    static var prod: LentilUseCases {

        let cumin = CuminUseCases(
            auth: CuminUseCases.Auth.prod,
            secrets: ProductionSecretsStore()
        )

        return .init(
            _cumin: cumin,
            _yuca: YucaUseCases(
                cumin: cumin
            )
        )
    }
}

// MARK: - Mock

public extension LentilUseCases {

    static var mock: LentilUseCases {
        let cumin = CuminUseCases(
            auth: CuminUseCases.Auth.mock,
            secrets: MockSecureStore()
        )

        return .init(
            _cumin: cumin,
            _yuca: YucaUseCases(
                cumin: cumin
            )
        )
    }
}

