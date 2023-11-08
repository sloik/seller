import SwiftUI

struct ContentView: View {
    
    @Environment(ViewModel.self) var viewModel
    @State var isAlertDisplayed: Bool = false
    @State var exceptionMessage: String = ""
    
    var body: some View {
        Form {
            SaveSectionView(isAlertDisplayed: $isAlertDisplayed, exceptionMessage: $exceptionMessage)
            GetSectionView(isAlertDisplayed: $isAlertDisplayed, exceptionMessage: $exceptionMessage)
            ListView(isAlertDisplayed: $isAlertDisplayed, exceptionMessage: $exceptionMessage)
        }
        .alert(isPresented: $isAlertDisplayed) {
            Alert(
                title: Text(Constants.error),
                message: Text(exceptionMessage),
                dismissButton: .default(Text(Constants.ok))
            )
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    ContentView()
}
