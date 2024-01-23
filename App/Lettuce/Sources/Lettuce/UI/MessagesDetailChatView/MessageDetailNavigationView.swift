// system
import SwiftUI

struct MessageDetailNavigationView: View {

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode

    @Bindable var viewModel: MessageDetailChatViewModel

    init(viewModel: MessageDetailChatViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                NavigationHeaderMessageDetailView()
                Divider()
                    .overlay( .design(color: .gray71, with: colorScheme) )

                ForEach(viewModel.messages.messages) { message in
                    message.text
                }

                Divider()

                ScrollView {
                    Text("Today")
                        .design(padding: .big([.top, .bottom]))
                    MessageBubble(geometry: geometry, isInterlocutor: true)
                    MessageSpacer()
                    MessageBubble(geometry: geometry, isInterlocutor: false)
                    MessageSpacer()
                    MessageBubble(geometry: geometry, isInterlocutor: true)
                }
                Spacer()
                TypeMessageView(viewModel: viewModel).ignoresSafeArea(.all)
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

    private struct MessageBubble: View {

        @Environment(\.colorScheme) private var colorScheme
        private let isInterlocutor: Bool
        private let geometry: GeometryProxy
        private let alignment: Alignment
        private let horizontalAlignment: HorizontalAlignment
        private let cornerRadius: CGFloat = 18

        init(geometry: GeometryProxy, isInterlocutor: Bool) {
            self.geometry = geometry
            self.isInterlocutor = isInterlocutor
            self.alignment = isInterlocutor ? .leading : .trailing
            self.horizontalAlignment = isInterlocutor ? .leading : .trailing
        }

        var body: some View {
            VStack(alignment: horizontalAlignment, spacing: 0) {
                Text("Hi! your last shot was realy good!")
                    .design(
                        padding: .smal(.vertical), 
                        padding: .base(.horizontal)
                    )
                    .background(isInterlocutor
                                ? .design(color: .gray92, with: colorScheme)
                                : .design(color: .gray69, with: colorScheme),
                                in: RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius)))
                    .design(padding: .smal(.bottom))
                    .design(padding: .large(.horizontal))
                Text("9:23")
                    .foregroundStyle( .design(color: .gray5958, with: colorScheme) )
                    .design(padding: .large(.horizontal))
            }
            .frame(width: geometry.size.width, alignment: alignment)
        }
    }

    private struct TypeMessageView: View {

        @Bindable private var viewModel: MessageDetailChatViewModel

        init(viewModel: MessageDetailChatViewModel) {
            self.viewModel = viewModel
        }

        var body: some View {
            VStack {
                Divider()
                HStack(spacing: 0) {
                    TextField("Type a message", text: $viewModel.conversationMessage, axis: .vertical)
                        .lineLimit(viewModel.conversationLineLimit)
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
