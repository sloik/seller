
import Foundation
import SwiftUI
import UIKit

struct DebugView: View {

    @Environment(\.dismiss) var dismiss

    @State private var globalNetworkingEnvironment: Bool = true

    var body: some View {

        NavigationView {
            List {
                Section(header: HeaderView(text: "🌐 Global")) {
                    Text("Item")
                    Toggle("Networking Environment", isOn: $globalNetworkingEnvironment)
                        .onChange(of: globalNetworkingEnvironment) { old, new in
                            print(#function, old, new)
                        }
                }

                Section(header: HeaderView(text: "🫐 Lentil")) {
                    Text("Item")
                }

                Section(header: HeaderView(text: "🥬 Lettuce")) {
                    Text("Item")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("⚙️ Debug")
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

struct HeaderView: View {

    let text: String

    var body: some View {
        Text(text)
            .font(.title3)
            .bold()
    }
}
