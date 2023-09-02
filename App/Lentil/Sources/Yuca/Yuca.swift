// system
import Foundation

// local
import SecretsStore
import Cumin

// 3rd party
import AliasWonderland

var Yuca: YucaUseCases!

package struct YucaUseCases {

    private (set) var cumin: CuminUseCases

    package init(
        cumin: CuminUseCases
    ) {
        self.cumin = cumin
    }
}
