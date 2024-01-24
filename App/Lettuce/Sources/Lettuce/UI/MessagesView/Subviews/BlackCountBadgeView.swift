
import SwiftUI

struct BlackCountBadgeView: View {

    let count: Int

    var body: some View {
        ZStack {
            Circle()
                .frame(height: 23)
            "\(count)"
                .font(.custom("SF Pro Display", fixedSize: 14))
                .foregroundColor(.white)
        }
        .design(padding: .custom(edges: .top, length: 4))
    }
}

