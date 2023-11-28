// system
import SwiftUI

struct PlaceholderSearch: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .frame(height: 32)
            .design(padding: .base(.horizontal))
            .foregroundColor(Color.gray.opacity(0.12))
            .design(padding: .base(.bottom))
    }
}
