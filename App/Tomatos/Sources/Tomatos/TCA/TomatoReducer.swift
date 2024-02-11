
import Foundation

import ComposableArchitecture

@Reducer
struct Tomato {

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .refresh:
                state.counter += 1
                return Effect.none
            }
        }
    }
}
