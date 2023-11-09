
import Foundation
import SwiftUI
import UIKit
import Observation

struct DebugView: View {

    struct Item: Hashable {

        enum Destination: Equatable {
            case networking
        }

        let name: String
        let value: String
        let destination: Destination
    }

    @Environment(\.dismiss) var dismiss

    let globalItems: [Item] = [
        Item(name: "Networking Environment", value: "unknown", destination: .networking)
    ]

    @State private var globalNetworkingEnvironment: Bool = true

    @State private var path = NavigationPath()

    var body: some View {

        NavigationStack(path: $path) {
            List {
                Section(header: HeaderView(text: "🌐 Global")) {
                    ForEach(globalItems, id: \.name) { listItem in
                        NavigationLink(value: listItem) {
                            TextDetailRow(title: listItem.name, text: listItem.value)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
            .navigationTitle("⚙️ Debug")
            .navigationDestination(for: Item.self) { item in
                switch item.destination {
                case .networking: NetworkingApiClientChooser()
                }
            }
        }
    }
}
