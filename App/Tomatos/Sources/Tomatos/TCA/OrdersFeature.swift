
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

                return .run { send in
                    // TODO: make API call here
                    await send( .refreshedResponse(forms: []) )
                }

            case .refreshedResponse(let forms):
                state.forms = forms

                return Effect.none
            }
        }
    }
}
