// system
import SwiftUI

import Lentil

public struct MyAccountView: View {

    @State private var model = MyAccountViewModel()

    public init(){}

    public var body: some View {
        NavigationStack(path: $model.path) {
            ZStack {
                LoginView(model: model)
                    .opacity( model.opacity(for: .login) )

                UserProfileView(model: model)
                    .opacity( model.opacity(for: .profile) )
            }

        }
    }
}

#Preview {
    MyAccountView()
}

struct UserProfileView: View {
    @Bindable var model: MyAccountViewModel

    var body: some View {

        VStack {
            Text("User Profile")
            
            Button("Logout", action: model.logout)
        }
    }
}

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
