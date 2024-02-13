
import Foundation
import OSLog

import Onion

import ComposableArchitecture

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

                    let orders = UserOrdersRequest()
                    

                    // TODO: make API call here
                    await send( .refreshOrdersListResponse(forms: []) )
                }

            case .refreshOrdersListResponse(let forms):
                state.forms = forms

                return Effect.none
            }
        }
    }
}
