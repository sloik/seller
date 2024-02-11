
import Foundation
import ComposableArchitecture


enum Action: Equatable {
    case increaseCounter
    case decreaseCounter
}



//let store = Store(
//    initialState: State(),
//    reducer: reducer,
//    environment: Environment()
//)
//
//let reducer = Reducer<State, Action, Environment> { state, action, environment in
//    switch action {
//    case .increaseCounter:
//        state.counter += 1
//        return .none
//    case .decreaseCounter:
//        state.counter -= 1
//        return .none
//    }
//}
