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

        let data: Data

        init(data: Data) {
            self.data = data
        }

        var body: some View {
            if let image = UIImage(data: data) {
                return Image(uiImage: image)
            }

            return Image(uiImage: UIImage(systemName: "aqi.high") ?? UIImage())
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
