import SwiftUI

internal struct MessageBubble: View {

    @Environment(\.colorScheme) private var colorScheme
    private let message: Message
    private let geomerty:GeometryProxy
    private var alignment: Alignment {
        message.author.isInterlocutor ? .leading : .trailing
    }
    private var horizontalAlignment: HorizontalAlignment {
        message.author.isInterlocutor ? .leading : .trailing
    }
    private let cornerRadius: CGFloat = 18

    init(geometry: GeometryProxy, message: Message) {
        self.message = message
        self.geomerty = geometry
    }

    var body: some View {
        VStack(alignment: horizontalAlignment, spacing: 0) {
            VStack {

                if let attatchemnt =  message.attachments.first {
                    HStack {
                        attatchemnt.mimeType.or(.unknown).asImage
                        attatchemnt.fileName
                    }
                    .foregroundColor(.cyan)
                }

                message.text

            }
            .design(typography: .label(weight: .light))
            .design(
                padding: .small(.vertical),
                padding: .base(.horizontal)
            )

            .background(message.author.isInterlocutor
                            ? .design(color: .gray92, with: colorScheme)
                            : .design(color: .gray69, with: colorScheme),
                            in: RoundedRectangle(cornerSize: CGSize(width: cornerRadius, height: cornerRadius)))



                .design(padding: .small(.bottom))
                .design(padding: .large(.horizontal))
            Text(message.createdAt.isoDate?.design(formatter: .relative) ?? "")
                .foregroundStyle( .design(color: .gray5958, with: colorScheme) )
                .design(padding: .large(.horizontal))
        }
        .frame(width: geomerty.size.width, alignment: alignment)
    }

//    func AttachementButton() -> any View {
//        return Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//        })
//    }
}
