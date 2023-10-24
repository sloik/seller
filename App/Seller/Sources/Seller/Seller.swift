
import Lentil
import SwiftUI
import OptionalAPI

public final class Seller {



    public init() {
        
    }

    public func takeOff() {
        LentilUseCases.start(env: .prod)
    }

    public var body: some View {
        MainView()
    }
}
