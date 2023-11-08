import SwiftUI

struct GetSectionView: View {
    
    @State private var keychainKeyValue: String = ""
    @State private var keychainRetrievedValue: String = ""
    
    @Binding var isAlertDisplayed: Bool
    @Binding var exceptionMessage: String
    
    @Environment(ViewModel.self) var viewModel
    
    @ViewBuilder
    var body: some View {
        Section(header: Text(Constants.getValueHeaderTitle)) {
            KWDTextField(text: $keychainKeyValue, title: Constants.getSectionTextFieldKeyValue)
            HStack {
                Spacer()
                Button(Constants.getButtonTtile) {  getKeychainValue() }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            HStack {
                Spacer()
                Text(keychainRetrievedValue)
                Spacer()
            }
        }
    }
}

extension GetSectionView  {
    func getKeychainValue() {
        do {
            keychainRetrievedValue = try viewModel.getValueFromKeychain(key: keychainKeyValue)
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
