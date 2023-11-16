// system
import SwiftUI

struct PlaceholderSearch: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .frame(height: 32)
            .padding(.horizontal, 16)
            .foregroundColor(Color.gray.opacity(0.12))
            .padding(.bottom, 15)
    }
}
