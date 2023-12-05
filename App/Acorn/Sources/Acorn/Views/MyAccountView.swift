// system
import SwiftUI

import Lentil

struct MyAccountView: View {

    @State private var model = MyAccountViewModel()

    init(){}

    var body: some View {
        ZStack {
            LoginView(model: model)
                .opacity( model.opacity(for: .login) )

            UserProfileView(model: model)
                .opacity( model.opacity(for: .profile) )
        }
    }
}

#Preview {
    MyAccountView()
}
