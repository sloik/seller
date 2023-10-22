
import SwiftUI

struct ListView: View {
    
    @Environment(ViewModel.self) var viewModel
    
    @Binding var isAlertDisplayed: Bool
    @Binding var exceptionMessage: String
    
    @ViewBuilder
    var body: some View {
        Section(header: Text(Constants.listViewHeadeTitle)) {
            List {
                ForEach(Array(viewModel.keychainItems.keys), id: \.self) { key in
                    HStack {
                        Text(key)
                        Spacer()
                        Text(viewModel.keychainItems[key] ?? Constants.noValueUnderKey)
                    }
                }
                .onDelete(perform: deleteValue(indexSet:))
            }
        }
    }
}

extension ListView  {
    func deleteValue(indexSet: IndexSet ) {
        do {
            let keysArray:Array<String> = Array(viewModel.keychainItems.keys)
            //Not sure what to do here, maybe better is to force unwrap and let it crash... ?
            guard let givenIndex = indexSet.first else { return }
            try viewModel.deleteKeychainValue(key: keysArray[givenIndex])
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
