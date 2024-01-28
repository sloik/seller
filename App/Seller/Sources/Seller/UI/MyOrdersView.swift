// system
import SwiftUI

struct MyOrdersView: View {
    // @Bindable var model: ThreadsModel
    @Environment(\.colorScheme) private var colorScheme
    private let iconWidth: CGFloat = 24.0
    //
    //    init(model: ThreadsModel) {
    //        self.model = model
    //    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Zamówienia")
                    .design(typography: .custom(weight: .medium, size: 28))
                    .design(padding: .custom(edges: .leading, length: 28))
                Spacer()
                Button(action: {
                    print("Three dots tapped")
                }, label: {
                    Image("threeDotsVerticalIcon").resizable().foregroundColor(.black).frame(width: iconWidth, height: iconWidth)
                        .design(padding: .custom(edges: .horizontal, length: 8))
                })
                Button(action: {
                    print("Search icon tapped")
                }, label: {
                    Image("searchIcon").resizable().foregroundColor(.black).frame(width: iconWidth, height: iconWidth)
                        .padding(.trailing, 13)
                        .design(padding: .smal(.trailing))
                })
            }
            .frame(height: 77)
            Divider()
                .overlay( .design(color: .gray71, with: colorScheme) )
            OrderPreviewView()
            OrderPreviewView()

            Spacer()
        }
    }
}
