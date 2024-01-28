//
//  SwiftUIView.swift
//  
//
//  Created by Dominika Kokowicz on 28/01/2024.
//

import SwiftUI

struct OrderPreviewView: View {

    private let offerWidth = 86.0
    private let offerHeight = 89.0

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: "https://avatars.githubusercontent.com/u/50965392?s=64&v=4")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("offerPlaceholder").resizable()

            }
            .frame(width: offerWidth, height: offerHeight)
            .design(padding: .bigger(.leading))

            Spacer()
            VStack(spacing: 0) {
                "Notes narcisius A5 wielokolorowy, kropki narcisius"
                    .lineLimit(1)
                "Notes narcisius A5 wielokolorowy, kropki narcisius"
                    .lineLimit(1)
                "Notes narcisius A5 wielokolorowy, kropki narcisius"
                    .lineLimit(1)
                "Notes narcisius A5 wielokolorowy, kropki narcisius"
                    .lineLimit(1)
            }
        }
        .design(padding: .bigger(.top))

    }
}

#Preview {
    OrderPreviewView()
}
