// system
import SwiftUI

struct MessagesFilterType: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let isChecked: Bool
}

@Observable class MyMessagesViewModel: ObservableObject {
   
    var searchFilterTextField: String = ""
    var showingFilterSearchPopup = false

    var filterTypes = [
        MessagesFilterType(title: "Nieprzeczytane", isChecked: false),
        MessagesFilterType(title: "Bez odpowiedzi", isChecked: false)
    ]
}
