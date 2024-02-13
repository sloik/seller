
import SwiftUI

import Onion
import ComposableArchitecture

private enum NetworkingHandlerKey: DependencyKey {
    typealias Value = NetworkingHandlerType

    static var liveValue: any Value = MockNetworkingHandler()
    static var previewValue: any Value = MockNetworkingHandler()
}

extension DependencyValues {

    var networkingHandler: NetworkingHandlerType {
        get { self[NetworkingHandlerKey.self] }
        set { self[NetworkingHandlerKey.self] = newValue }
    }
}

public final class TomatosFactory {

    private let networkingHandler: NetworkingHandlerType

    private let store: StoreOf<OrdersFeature>

    public init(
        networkingHandler: NetworkingHandlerType
    ) {
        self.networkingHandler = networkingHandler

        self.store = Store(
            initialState: OrdersFeature.State()
        ) {
            OrdersFeature()
                ._printChanges()
                .dependency(\.networkingHandler, networkingHandler)
        }
    }
}

// MARK: - Public

public extension TomatosFactory {
    /// Main entry point view for user profile.
    func makeEntryView() -> some View {
        MyOrdersView(store: store)
    }
}

// MARK: - Internal

extension TomatosFactory {
}
