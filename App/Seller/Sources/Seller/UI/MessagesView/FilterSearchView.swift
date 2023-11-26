// system
import SwiftUI

struct FilterSearchView: View {
    
    private var viewModel: MyMessagesViewModel
    private let cornerRadiusSize = 10.0
    private let lightGrayBackground = Color(red: 0.95, green: 0.95, blue: 0.96)

    init(viewModel: MyMessagesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                FilterHeader(viewModel: viewModel)
                VStack(spacing: 0) {
                    FilterCells(viewModel: viewModel)
                }
                .padding(.all, 16)
                Spacer()
                ActionButtonViewStack(geometry: geometry, viewModel: viewModel)
            }
            .background(lightGrayBackground)
        }
    }
    
    private struct FilterCells: View {
        private var viewModel: MyMessagesViewModel

        init(viewModel: MyMessagesViewModel) {
            self.viewModel = viewModel
        }
        
        var body: some View {
            ForEach(viewModel.filterTypes, id: \.self) { filter in
                VStack(spacing: 0) {
                    Text(filter.title)
                        .padding(.leading, 16)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                    if let lastId = viewModel.filterTypes.last?.id, lastId != filter.id {
                        Divider()
                    }
                }
            }
        }
    }
    
    private struct FilterHeader: View {
        @Bindable private var viewModel: MyMessagesViewModel
        
        private let lightGray = Color(red: 0.46, green: 0.46, blue: 0.5).opacity(0.12)
        private let cornerRadiusSize = 10.0
        
        init(viewModel: MyMessagesViewModel) {
            self.viewModel = viewModel
        }
        
        var body: some View {
            VStack(spacing: 0) {
                Text("Filtruj")
                    .font(Font.custom("SF Pro", size: 17).weight(.semibold))
                    .padding(.top, 40)
                    .padding(.bottom, 12)
                HStack {
                    Image("searchGlyphIcon")
                        .padding(.leading, 8)
                    TextField("Nazwa klienta (login Allegro)", text: $viewModel.searchFilterTextField)
                }
                .frame(height: 36)
                .background(RoundedRectangle(cornerSize: CGSize(width: cornerRadiusSize, height: cornerRadiusSize)).foregroundStyle(lightGray))
                .padding(.bottom, 20)
                .padding(.horizontal, 16)
            }
        }
    }

    private struct ActionButtonViewStack: View {
        private var viewModel: MyMessagesViewModel
        
        private let geometry: GeometryProxy
        private let mediumGray = Color(red: 0.69, green: 0.69, blue: 0.69)
        
        init(geometry: GeometryProxy, viewModel: MyMessagesViewModel) {
            self.geometry = geometry
            self.viewModel = viewModel
        }
        
        var body: some View {
            HStack(alignment: .center, spacing: 0) {
                FilterActionButton(geometry: geometry,
                                   action: { viewModel.showingFilterSearchPopup.toggle() },
                                   backgroundColor: mediumGray,
                                   foregroundColor: .black,
                                   title: "Anuluj")
                Spacer()
                    .frame(width: geometry.size.width * 0.1)
                FilterActionButton(geometry: geometry,
                                   action: { },
                                   backgroundColor: .black,
                                   foregroundColor: .white,
                                   title: "Filtruj")
            }
            .padding(.bottom, 42)
        }
    }

    private struct FilterActionButton: View {
        private let geometry: GeometryProxy
        private let action: () -> Void
        private let backgroundColor: Color
        private let foregroundColor: Color
        private let title: String
        private let cornerRadiusSize = 10.0
        
        init(geometry: GeometryProxy, action: @escaping () -> Void, backgroundColor: Color, foregroundColor: Color, title: String) {
            self.geometry = geometry
            self.action = action
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.title = title
        }
        
        var body: some View {
            Button(action: { action() }, label: {
                Text(title)
                    .foregroundStyle(foregroundColor)
                    .frame(width: geometry.size.width * 0.38, height: 47)
                    .background(RoundedRectangle(cornerSize: CGSize(width: cornerRadiusSize, height: cornerRadiusSize)).foregroundStyle(backgroundColor))
            })
        }
    }
}