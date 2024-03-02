// system
import SwiftUI

struct MessageDetailPreview: View {

    @Bindable var model: MessageDetailChatModel

    init(model: MessageDetailChatModel) {
        self.model = model
    }

    var body: some View {

        ForEach(model.messages) { message in
            VStack {
                message.text
                    .design(typography: .label(weight: .regular))
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: message.author.isInterlocutor ? .leading : .trailing
            )
        }
    }
}

struct MessageDetailNavigationView: View {

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode

    @Bindable var model: MessageDetailChatModel

    @State private var isAttachmentPresented: Bool = false
    @State private var imageData: Data?

    init(model: MessageDetailChatModel) {
        self.model = model
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                NavigationHeaderMessageDetailView()
                Divider()
                    .overlay( .design(color: .gray71, with: colorScheme) )

                ScrollView {
                    Text("Today")
                        .design(padding: .big([.top, .bottom]))
                    ForEach(model.messages) { message in
                        MessageBubble(
                            geometry: geometry,
                                      message: message,
                                      buttonAction: {

                            
                                          guard let att = message.attachments.first else { return }

                                          Task { @MainActor in
//                                              let data = try await model.download(att)

                                              let imageDummy = UIImage(systemName: "figure.walk")!.jpegData(compressionQuality: 0.2)

                                              self.imageData = imageDummy

//                                              print("🛤️", data)
                                              isAttachmentPresented.toggle()

                                          }

                                      }
                        )
                        MessageSpacer()
                    }
                }.sheet(isPresented: $isAttachmentPresented, content: {
                    DataImageView(data: $imageData)
                })
                Spacer()
                TypeMessageView(model: model).ignoresSafeArea(.all)
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
#if canImport(UIKit)
            .toolbar(.hidden, for: .tabBar)
#endif
        }
    }

    private struct NavigationHeaderMessageDetailView: View {

        @Environment(\.colorScheme) private var colorScheme
        @Environment(\.presentationMode) private var presentationMode

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
                ZStack {
                    Circle()
                        .frame(width: circleSize, height: circleSize)
                        .foregroundStyle( .design(color: .gray91, with: colorScheme) )
                    Text("AB")
                        .design(typography: .custom(weight: .medium, size: 21))
                }
                .design(padding: .smaller(.leading))
                VStack(alignment: .leading, spacing: 0) {
                    Text("User name")
                        .design(typography: .label(weight: .medium))
                        .design(padding: .tiny(.bottom))
                    Text("{offer:title}")
                        .design(typography: .custom(weight: .medium, size: 14))
                        .foregroundStyle( .design(color: .gray55, with: colorScheme) )
                }
                Spacer()
            }
            .frame(height: 83)
            .background(Color.white)
        }
    }

    private struct MessageSpacer: View {
        var body: some View {
            Spacer()
                .frame(height: 10)
        }
    }

    private struct TypeMessageView: View {

        @Bindable private var model: MessageDetailChatModel

        init(model: MessageDetailChatModel) {
            self.model = model
        }

        var body: some View {
            VStack {
                Divider()
                HStack(spacing: 0) {
                    TextField("Type a message", text: $model.conversationMessage, axis: .vertical)
                        .lineLimit(model.conversationLineLimit)
                        .design(padding: .large(.leading))
                    Spacer()
                    Button(action: {
                        print("Attachment clicked")
                    }, label: {
                        Image(systemName: "paperclip")
                            .design(padding: .large(.horizontal))
                    })
                }
                .frame(height: 78)
                .background(Color.white)
            }
        }
    }
}

struct DataImageView: View {

    @Environment(\.dismiss) var dismiss
    private let data: Binding<Data?>

    init(data:  Binding<Data?>) {
        self.data = data
    }

    var body: some View {
        var image = UIImage(data: data.wrappedValue!)
        Image(uiImage: image ?? UIImage(systemName:"figure.archery")!)
    }
}
