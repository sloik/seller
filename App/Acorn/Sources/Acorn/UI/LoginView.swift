
import SwiftUI

import Lentil

struct LoginView: View {

    @Bindable var model: MyAccountViewModel

    public var body: some View {
        NavigationStack(path: $model.path) {

            Button("Login", action: model.didTapLogin)
                .sheet(isPresented: $model.loginWebViewIsPresented) {

                    Lentil
                        .loginUI(didLogin: model.didLogin)
#if os(macOS)
                        .design(sheet: .regular)
#endif
                }
        }
    }
}
