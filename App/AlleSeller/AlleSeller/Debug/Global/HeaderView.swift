
import SwiftUI

struct HeaderView: View {

    let text: String

    var body: some View {
        Text(text)
            .font(.title3)
            .bold()
    }
}
