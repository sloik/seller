// system
import SwiftUI

import Lentil
import Onion

struct MyAccountView: View {

    @State private var model: MyAccountViewModel

    init(model: MyAccountViewModel) {
        self.model = model
    }

    var body: some View {

        VStack {

            Button("Force Refresh Token") {
                model.didTapRefreshToken()
            }

            ZStack {
                LoginView(model: model)
                    .opacity( model.opacity(for: .login) )

                UserProfileView(model: model)
                    .opacity( model.opacity(for: .profile) )
                    .onAppear(perform: model.onAppear)
            }
        }
    }
}

#Preview {
    MyAccountView(
        model: .init(
            loginHandler: Lentil,
            networkingHandler: MockNetworkingHandler()
        )
    )
}
