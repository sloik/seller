
import Foundation

import ComposableArchitecture
import OSLog

// Breaks in Xcode Beta 15.3
//private let logger = Logger(subsystem: "Tomatos", category: "Reducer")

@Reducer
struct OrdersFeature {

    var body: some Reducer<State, Action> {
        Reduce { state, action in
//            logger.log("Reducing \(action)...")

            switch action {
            case .refreshOrdersList:
                
                print("Reducing refresh... No state mutation should return effect of fetching orders.")

                return Effect.none
            }
        }
    }
}
