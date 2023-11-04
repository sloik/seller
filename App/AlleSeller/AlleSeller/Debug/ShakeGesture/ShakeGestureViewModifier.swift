
import SwiftUI
import AliasWonderland

struct ShakeGestureViewModifier: ViewModifier {

    let action: SideEffectClosure

    private var deviceShakeNotificationPublisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)
    }

    func body(content: Content) -> some View {
        content
            .onReceive( deviceShakeNotificationPublisher ) { _ in
                action()
            }
    }
}
