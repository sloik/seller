import SwiftUI

struct KWDDeleteSectionView: View {
    
    @State private var keychainKeyValue: String = ""
    @State private var isDeleted: Bool = false
    @Environment(KWDViewModel.self) var viewModel
    
    @Binding var isAlertDisplayed: Bool
    @Binding var exceptionMessage: String
    
    @ViewBuilder
    var body: some View {
        Section(header: Text(Constants.dleteValueHeaderTitle)) {
            KWDTextField(text: $keychainKeyValue, title: Constants.deleteSectionTextFieldKeyValue)
            HStack {
                Spacer()
                Button(Constants.deleteButtonTitle) {
                    do {
                        try viewModel.deleteKeychainValue(key: keychainKeyValue)
                    } catch let error {
                        if let kwdError = error as? KWDException {
                            exceptionMessage = kwdError.description
                        } else {
                            exceptionMessage = error.localizedDescription
                        }
                        isAlertDisplayed = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                Spacer()
            }
        }
    }
}


