// system
import SwiftUI


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
