
import Lentil
import SwiftUI
import OptionalAPI

public final class Seller {

    public enum Env {
        case prod
        case sandbox
    }

    public init() {
    }

    public func takeOff(env: Env) {
        LentilUseCases.start(env: env.lentilEnv)
    }

    public var body: some View {
        MainView()
    }
}

private extension Seller.Env {

    var lentilEnv: LentilUseCases.Env {
        switch self {
        case .prod:
            return .prod
        case .sandbox:
            return .mock
        }
    }
}
