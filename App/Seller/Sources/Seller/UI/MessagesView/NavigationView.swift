// system
import SwiftUI

struct NavigationView: View {
    @Bindable var viewModel: MyMessagesViewModel
    private let filterPopupHeight = stride(from: 0.4, through: 1.0, by: 0.4).map { PresentationDetent.fraction($0) }
    private let iconWidth: CGFloat = 24.0
    private let dividerColor = Color(red: 0xB5 / 255.0, green: 0xB5 / 255.0, blue: 0xB5 / 255.0)
    
    init(viewModel: MyMessagesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Wiadomości")
                    .font(.custom("SF Pro Display", size: 28))
                    .fontWeight(.medium)
                    .design(padding: .custom(edges: .leading, length: 28))
                Spacer()
                Button(action: { viewModel.showingFilterSearchPopup.toggle() },
                       label: {
                    Image("threeDotsVerticalIcon").resizable().foregroundColor(.black).frame(width: iconWidth, height: iconWidth)
                        .design(padding: .custom(edges: .horizontal, length: 8))
                })
                Button(action: { viewModel.showingFilterSearchPopup.toggle() },
                       label: {
                    Image("searchIcon").resizable().foregroundColor(.black).frame(width: iconWidth, height: iconWidth)
                        .padding(.trailing, 13)
                        .design(padding: .smaller(.trailing))
                })
            }
            .frame(height: 77)
            Divider()
                .overlay(dividerColor)
        }
        .sheet(isPresented: $viewModel.showingFilterSearchPopup) {
            FilterSearchView(viewModel: viewModel)
                .presentationDetents(Set(filterPopupHeight))
        }
    }
}
