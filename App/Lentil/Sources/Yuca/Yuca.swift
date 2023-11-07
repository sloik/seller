// system
import Foundation

// local
import SecretsStore
import Cumin
import Onion

// 3rd party
import AliasWonderland

package private(set) var Yuca: YucaUseCases!

package struct YucaUseCases {

    private (set) var cumin: CuminUseCases

    package init(
        cumin: CuminUseCases
    ) {
        self.cumin = cumin
    }
}

package extension YucaUseCases {

    static func takeOffYuca(cumin: CuminUseCases) {
        Yuca = YucaUseCases(cumin: cumin)
    }
}
