import SwiftUI
import PDFKit

internal struct AttatchmentView: View {

    @Environment(\.dismiss) var dismiss

    private let data: Data
    private let attchament: Attachment

    init(data: Data, attachment: Attachment) {
        self.data = data
        self.attchament = attachment
    }

    var body: some View {

        switch attchament.mimeType {
        case .imageJpeg, .imagePng:
            AttachmentImageView(data: data)
        case .pdf:
            PDFKitView(data: data)
        case .none, .some(.unknown):
            UuuupsView()
        }

    }

    struct UuuupsView: View {
        var body: some View {
            VStack {
                Text("Upppps we can not opent that type of attachement")
            }
        }
    }


    struct AttachmentImageView: View {

        @State private var currentZoom = 0.0
        @State private var totalZoom = 1.0

        let data: Data

        init(data: Data) {
            self.data = data
        }

        var body: some View {
            if let image = UIImage(data: data) {
                return Image(uiImage: image)
                    .scaleEffect(currentZoom + totalZoom)
                    .gesture(
                             MagnifyGesture()
                                 .onChanged { value in
                                     currentZoom = value.magnification - 1
                                 }
                                 .onEnded { value in
                                     totalZoom += currentZoom
                                     currentZoom = 0
                                 }
                         )
                    .accessibilityZoomAction { action in
                                   if action.direction == .zoomIn {
                                       totalZoom += 0.1
                                   } else {
                                       totalZoom -= 0.1
                                   }
                               }
            }

            return Image(uiImage: UIImage(systemName: "aqi.high") ?? UIImage())
                .scaleEffect(currentZoom + totalZoom)
                .gesture(
                         MagnifyGesture()
                             .onChanged { value in
                                 currentZoom = value.magnification - 1
                             }
                             .onEnded { value in
                                 totalZoom += currentZoom
                                 currentZoom = 0
                             }
                     )
                .accessibilityZoomAction { action in
                               if action.direction == .zoomIn {
                                   totalZoom += 0.1
                               } else {
                                   totalZoom -= 0.1
                               }
                           }
        }

    }


    struct PDFKitView: UIViewRepresentable {

        private let data: Data

        init(data: Data) {
            self.data = data
        }

        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()

            pdfView.document = PDFDocument(data: self.data)

            pdfView.autoScales = true
            return pdfView
        }

        func updateUIView(_ pdfView: PDFView, context: Context) {
            pdfView.document = PDFDocument(data: data)
        }
    }
}
