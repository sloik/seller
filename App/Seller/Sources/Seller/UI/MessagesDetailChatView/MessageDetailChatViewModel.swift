// system
import SwiftUI

@Observable class MessageDetailChatViewModel: ObservableObject {

    var conversationMessage: String = ""
    let conversationLineLimit = 5
}
