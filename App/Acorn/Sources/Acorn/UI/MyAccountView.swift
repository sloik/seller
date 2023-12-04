// system
import SwiftUI

import Lentil

public struct MyAccountView: View {

    @State private var model = MyAccountViewModel()

    public init(){}

    public var body: some View {
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
