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

        VStack(alignment: .leading) {
            ZStack {
                LoginView(model: model)
                    .opacity( model.opacity(for: .login) )
                    .border(.blue)

                UserProfileView(model: model)
                    .frame( maxWidth: .infinity)
                    .padding(.top, 50)
                    .opacity( model.opacity(for: .profile) )
                    .onAppear(perform: model.onAppear)

            }

            #if DEBUG

            DebugView(model: $model)
                .padding()

            #endif
        }
    }
}

private struct DebugView: View {

    @Binding var model: MyAccountViewModel

    var body: some View {

        VStack(alignment: .leading) {
            "🩺 Debug"
                .font(.headline)
                .padding([.top, .trailing, .bottom], 20)

            Button("Force Refresh Token") {
                model.didTapRefreshToken()
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
