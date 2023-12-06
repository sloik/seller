
import SwiftUI

struct UserProfileView: View {
    @Bindable var model: MyAccountViewModel

    var body: some View {

        VStack {
            Text("User Profile")
            Text("Login: \(model.user?.login ?? "Unknown")")

            Button("Logout", action: model.didTapLogout)
        }
    }
}
