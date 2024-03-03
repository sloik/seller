import SwiftUI

internal struct NavigationHeaderMessageDetailView: View {

        @Environment(\.colorScheme) private var colorScheme
        @Environment(\.presentationMode) private var presentationMode

        var interlocutor: Interlocutor?
        var offerTitle: String

        private let circleSize: CGFloat = 63

        var body: some View {
            HStack(spacing: 0) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.black)
                        .design(padding: .base([.horizontal]))
                })
                InterlocutorAvatar(interlocutor: interlocutor)
                    .design(padding: .smaller(.vertical))
//                ZStack {
////                    Circle()
////                        .frame(width: circleSize, height: circleSize)
////                        .foregroundStyle( .design(color: .gray91, with: colorScheme) )
////                    Text("AB")
////                        .design(typography: .custom(weight: .medium, size: 21))
//                }
//                .design(padding: .smaller(.leading))
                VStack(alignment: .leading, spacing: 0) {
                    Text(interlocutor?.login ?? "")
                        .design(typography: .label(weight: .medium))
                        .design(padding: .tiny(.bottom))
                    Text("{offer:title}")
                        .design(typography: .custom(weight: .medium, size: 14))
                        .foregroundStyle( .design(color: .gray55, with: colorScheme) )
                }
                Spacer()

                Button(action: {
                    print("Attachment clicked")
                }, label: {
                    Image(systemName: "paperclip")
                        .design(padding: .large(.horizontal))
                })
            }
            .frame(height: 83)
            .background(Color.white)
        }
    }
