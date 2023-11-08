import SwiftUI

struct SaveSectionView: View {
    
    @Environment(ViewModel.self) var viewModel
    
    @State private var keychainKeyValue: String = ""
    @State private var keychainSavedValue: String = ""
    
    @Binding var isAlertDisplayed: Bool
    @Binding var exceptionMessage: String
    
    @ViewBuilder
    var body: some View {
        Section(header: Text(Constants.saveSectionHeaderTitle)) {
            KWDTextField(text: $keychainKeyValue, title: Constants.saveSectionTextFieldKeyValue)
            KWDTextField(text: $keychainSavedValue, title: Constants.saveSectionTextFieldValue).onSubmit { saveValue() }
        }
    }
}

extension SaveSectionView  {
    func saveValue() {
        do {
            try viewModel.saveValueToKeychain(keychainSavedValue, keyValue: keychainKeyValue)
        } catch let error {
            if let customException = error as? CustomException {
                exceptionMessage = customException.description
            } else {
                exceptionMessage = error.localizedDescription
            }
            isAlertDisplayed.toggle()
        }
    }
}
