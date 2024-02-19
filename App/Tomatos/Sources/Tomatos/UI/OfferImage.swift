
import SwiftUI

struct OfferImage: View {
    let imgURL: URL

    var body: some View {
        AsyncImage(
            url: imgURL,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}
