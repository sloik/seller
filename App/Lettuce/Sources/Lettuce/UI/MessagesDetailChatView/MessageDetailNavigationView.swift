// system
import SwiftUI
import PDFKit


struct MessageDetailNavigationView: View {

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode

    @Bindable var model: MessageDetailChatModel

    @State private var isAttachmentPresented: Bool = false
    @State private var imageData: (data: Data, attachment: Attachment)?

    init(model: MessageDetailChatModel) {
        self.model = model
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                NavigationHeaderMessageDetailView()
                Divider()
                    .overlay( .design(color: .gray71, with: colorScheme) )

                ScrollViewReader { proxy in
                    ScrollView {
                        Text("Today")
                            .design(padding: .big([.top, .bottom]))

                        VStack {
                            ForEach(model.messages) { message in
                                MessageBubble(
                                    geometry: geometry,
                                    message: message,
                                    buttonAction: {
                                        guard let att = message.attachments.first else { return }
                                        Task { @MainActor in
                                            let data = try await model.download(att)
                                            self.imageData = (data: data, attachment: att)
                                            isAttachmentPresented.toggle()
                                        }
                                    }
                                )
                                .id(message)
                                MessageSpacer()
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $model.scrolledMessage, anchor: .bottom)
                    .onChange(of: model.messages) {
                        if let msg = model.messages.last {
                            withAnimation {
                                proxy.scrollTo(msg, anchor: .bottom)
                            }
                        }
                    }
                    .onAppear {
                        if let msg = model.messages.last {
                            proxy.scrollTo(msg, anchor: .bottom)
                        }
                    }
                    .refreshable {
                        await model.loadOlderMessagesForThread()
                    }
                }
                .sheet(isPresented: $isAttachmentPresented, content: {
                    if let data = $imageData.wrappedValue {
                        AttatchmentView(
                            data:data.data,
                            attachment: data.attachment
                        )
                    }
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
