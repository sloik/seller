
import SwiftUI
import AliasWonderland

struct ShakeGestureViewModifier: ViewModifier {

    let shakeAction: SideEffectClosure

    #if os(iOS)
    private var deviceShakeNotificationPublisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)
    }
    #endif

    func body(content: Content) -> some View {
        content
        #if os(iOS)
            .onReceive( deviceShakeNotificationPublisher ) { _ in
                shakeAction()
            }
        #endif
    }
}
