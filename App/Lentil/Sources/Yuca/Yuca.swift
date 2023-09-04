// system
import Foundation

// local
import SecretsStore
import Cumin

// 3rd party
import AliasWonderland

package var Yuca: YucaUseCases!

package func takeOffYuca(cumin: CuminUseCases) {
    Yuca = YucaUseCases(cumin: cumin)
}

package struct YucaUseCases {

    private (set) var cumin: CuminUseCases

    package init(
        cumin: CuminUseCases
    ) {
        self.cumin = cumin
    }
}

package extension YucaUseCases {
    static var prod: YucaUseCases {
        .init(cumin: .prod)
    }

    static var mock: YucaUseCases {
        .prod
    }
}
