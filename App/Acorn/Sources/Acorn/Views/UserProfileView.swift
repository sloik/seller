
import SwiftUI

struct UserProfileView: View {
    @Bindable var model: MyAccountViewModel

    var body: some View {

        VStack {
            Text("User Profile")

            Button("Logout", action: model.didTapLogout)
        }
    }
}
