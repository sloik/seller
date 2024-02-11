// system
import SwiftUI

import ComposableArchitecture

public struct MyOrdersView: View {

    private let store: StoreOf<Tomato>

    public var body: some View {
        Text("My orders")
    }

    public init() {
        store = Store(
            initialState: Tomato.State()
        ) {
            Tomato()
        }
    }
}

#Preview {
    MyOrdersView()
}
