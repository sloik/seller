// system
import SwiftUI

// Internal

// 3rd
import OptionalAPI

struct MessagesView: View {
    @ObservedObject private var viewModel = MyMessagesViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView(viewModel: viewModel)
                .frame(height: 77)
            ScrollView {
                VStack(spacing: 17) {
                    MessagePreview()
                        .design(padding: .custom(edges: .top, length: 30))
                    MessagePreview(hasAttachment: true)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MessagesView()
}
