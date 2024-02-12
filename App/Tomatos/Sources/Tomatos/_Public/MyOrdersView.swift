// system
import SwiftUI

import ComposableArchitecture

public struct MyOrdersView {

    private let store: StoreOf<Tomato>

    public init() {
        store = Store(
            initialState: Tomato.State()
        ) {
            Tomato()
        }
    }
}

extension MyOrdersView: View {
    public var body: some View {
        Text("My orders")
            .onAppear {
                store.send(.refresh)
            }
    }
}

#Preview {
    MyOrdersView()
}
