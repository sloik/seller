// system
import SwiftUI

import ComposableArchitecture

struct MyOrdersView {

    private let store: StoreOf<OrdersFeature>

    init() {
        self.init(store: Store(
            initialState: OrdersFeature.State()
        ) {
            OrdersFeature()
                ._printChanges()
        })
    }

    init(store: StoreOf<OrdersFeature>) {
        self.store = store
    }
}

extension MyOrdersView: View {
    public var body: some View {
        Text("My orders")
            .onAppear {
                store.send(.refreshOrdersList)
            }
    }
}

#Preview {
    MyOrdersView(
        store: Store(
            initialState: OrdersFeature.State()
        ) {}
    )
}
