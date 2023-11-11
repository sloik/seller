
import SwiftUI

struct TextDetailRow: View {
    let title: String
    let text: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(text)
        }
    }
}
