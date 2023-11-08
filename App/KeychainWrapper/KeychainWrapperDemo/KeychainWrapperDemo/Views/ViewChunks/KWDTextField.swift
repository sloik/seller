import SwiftUI

struct KWDTextField: View {

    @Binding var text: String
    var title: String
    
    @ViewBuilder
    var body: some View {
        TextField(title, text: $text)
            .padding(.all).background(Color(.systemGray6)).border(Color.black)
    }
}
