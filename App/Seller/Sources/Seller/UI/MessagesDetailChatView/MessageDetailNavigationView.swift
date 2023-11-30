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
                ScrollView {
                    Text("Today")
                        .padding(.top, 22)
                        .padding(.bottom, 25)
                    MessageBubble(geometry: geometry, isInterlocutor: true)
                    MessageSpacer()
                    MessageBubble(geometry: geometry, isInterlocutor: false)
                    MessageSpacer()
                    MessageBubble(geometry: geometry, isInterlocutor: true)
                }
                Spacer()
                TypeMessageView(viewModel: viewModel).ignoresSafeArea(.all)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
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
                        .padding(.horizontal, 16)
                })
                ZStack {
                    Circle()
                        .frame(width: circleSize, height: circleSize)
                        .foregroundStyle( .design(color: .gray91, with: colorScheme) )
                    Text("AB")
                        .design(typography: .label(weight: .medium, size: 21))
                }
                .padding(.trailing, 10)
                VStack(alignment: .leading, spacing: 0) {
                    Text("User name")
                        .design(typography: .label(weight: .medium))
                        .padding(.bottom, 6)
                    Text("{offer:title}")
                        .design(typography: .label(weight: .medium, size: 14))
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
        private let smallerPadding: CGFloat = 10
        private let horizontalPadding: CGFloat = 29
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
                    .padding(.vertical, smallerPadding)
                    .padding(.horizontal, 14)
                    .background(isInterlocutor 
                                ? .design(color: .gray92, with: colorScheme)
                                : .design(color: .gray69, with: colorScheme),
                                in: RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius)))
                    .padding(.bottom, smallerPadding)
                    .padding(.horizontal, horizontalPadding)
                Text("9:23")
                    .foregroundStyle( .design(color: .gray5958, with: colorScheme) )
                    .padding(.horizontal, horizontalPadding)
            }
            .frame(width: geometry.size.width, alignment: alignment)
        }
    }

    private struct TypeMessageView: View {

        @Bindable private var viewModel: MessageDetailChatViewModel
        private let padding: CGFloat = 29

        init(viewModel: MessageDetailChatViewModel) {
            self.viewModel = viewModel
        }

        var body: some View {
            VStack {
                Divider()
                HStack(spacing: 0) {
                    TextField("Type a message", text: $viewModel.conversationMessage, axis: .vertical)
                        .lineLimit(viewModel.conversationLineLimit)
                        .padding(.leading, padding)
                    Spacer()
                    Button(action: {
                        print("Attachment clicked")
                    }, label: {
                        Image(systemName: "paperclip")
                            .padding(.horizontal, padding)
                    })
                }
                .frame(height: 78)
                .background(Color.white)
            }
        }
    }
}
