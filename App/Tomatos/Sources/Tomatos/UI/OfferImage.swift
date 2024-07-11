
import SwiftUI

struct OfferImage: View {
    let imgURL: URL

    var body: some View {
        AsyncImage(
            url: imgURL,
            content: { image in
                image
                    .resizable()
                    .frame(width: 64, height: 64)
                    .aspectRatio(contentMode: .fit)
            },
            placeholder: {
                ProgressView()
                    .frame(width: 64, height: 64)
            }
        )
    }
}
