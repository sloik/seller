
import SwiftUI
import AliasWonderland

extension View {
    public func onShakeGesture(_ action: @escaping SideEffectClosure) -> some View {
        modifier(ShakeGestureViewModifier(action: action))
    }
}
