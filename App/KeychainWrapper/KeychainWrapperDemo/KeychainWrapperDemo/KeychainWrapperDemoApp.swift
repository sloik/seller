import SwiftUI
import KeychainWrapper

@main
struct KeychainWrapperDemoApp: App {
    
    private let keychainWrapper: KeychainWrapper
    @State private var viewModel: ViewModel
    
    init() {
        keychainWrapper = KeychainWrapper()
        viewModel = ViewModel(keychainWrapper: keychainWrapper)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
      
    }
}
