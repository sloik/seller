// system
import SwiftUI

struct FilterSearchView: View {
    
    private var model: ThreadsModel
    private let cornerRadiusSize = 10.0
    private let lightGrayBackground = Color(red: 0.95, green: 0.95, blue: 0.96)

    init(model: ThreadsModel) {
        self.model = model
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                FilterHeader(model: model)
                VStack(spacing: 0) {
                    FilterCells(model: model)
                }
                .padding(.all, 16)
                Spacer()
                ActionButtonViewStack(geometry: geometry, model: model)
            }
            .background(lightGrayBackground)
        }
    }
    
    private struct FilterCells: View {
        private var model: ThreadsModel

        init(model: ThreadsModel) {
            self.model = model
        }
        
        var body: some View {
            ForEach(model.filterTypes, id: \.self) { filter in
                VStack(spacing: 0) {
                    Text(filter.title)
                        .padding(.leading, 16)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                    if let lastId = model.filterTypes.last?.id, lastId != filter.id {
                        Divider()
                    }
                }
            }
        }
    }
    
    private struct FilterHeader: View {
        @Environment(\.colorScheme) private var colorScheme

        @Bindable private var model: ThreadsModel
        
        private let cornerRadiusSize = 10.0
        
        init(model: ThreadsModel) {
            self.model = model
        }
        
        var body: some View {
            VStack(spacing: 0) {
                Text(String.localized("filter"))
                    .design(typography: .label(weight: .semibold))
                    .design(padding: .hugger(.top))
                    .design(padding: .small(.bottom))
                HStack {
                    Image("searchGlyphIcon")
                        .design(padding: .smaller(.leading))
                    TextField(String.localized("client_name_login"), text: $model.searchFilterTextField)
                }
                .frame(height: 36)
                .background(
                    RoundedRectangle(
                        cornerSize: CGSize(width: cornerRadiusSize, height: cornerRadiusSize)
                    )
                    .foregroundStyle( .design(color: .lightGray, with: colorScheme) )
                )
                .design(padding: .big(.bottom))
                .design(padding: .base(.horizontal))
            }
        }
    }

    private struct ActionButtonViewStack: View {
        @Environment(\.colorScheme) private var colorScheme

        private var model: ThreadsModel
        
        private let geometry: GeometryProxy

        init(geometry: GeometryProxy, model: ThreadsModel) {
            self.geometry = geometry
            self.model = model
        }
        
        var body: some View {
            HStack(alignment: .center, spacing: 0) {
                FilterActionButton(geometry: geometry,
                                   action: { model.showingFilterSearchPopup.toggle() },
                                   backgroundColor: .design(color: .mediumGray, with: colorScheme),
                                   foregroundColor: .black,
                                   title: String.localized("cancel"))
                Spacer()
                    .frame(width: geometry.size.width * 0.1)
                FilterActionButton(geometry: geometry,
                                   action: { },
                                   backgroundColor: .black,
                                   foregroundColor: .white,
                                   title: String.localized("filter"))
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
