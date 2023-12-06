
import SwiftUI

struct UserProfileView: View {
    @Bindable var model: MyAccountViewModel

    var body: some View {

        VStack {
            "User Profile"

            "Login: \(model.user?.login ?? "Unknown")"

            Button("Logout", action: model.didTapLogout)
        }
    }
}
