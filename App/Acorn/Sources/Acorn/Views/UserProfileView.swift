
import SwiftUI

struct UserProfileView: View {
    @Bindable var model: MyAccountViewModel

    var body: some View {

        VStack {

            UserAvatarView(login: model.user?.login ?? "Unknown")

            List {

                Section {

                    ForEach(0...5, id: \.self) { option in
                        HStack {
                            Image(systemName: "bell.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(.systemGray4))

                            "Option \(option)"
                        }
                    }
                }

                Section {
                    Button("Logout", action: model.didTapLogout)
                }
                .foregroundColor(.red)
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity)



        }
    }
}

private struct UserAvatarView: View {

    var login: String

    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(Color(.systemGray4))

            "\(login)"
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}
