
import Foundation
import SwiftUI
import UIKit
import Observation



@Observable
final class DebugModel {


}

struct TextDetailRow: View {
    let title: String
    let text: String

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(text)
        }
    }
}

struct GlobalEnvironmentView: View {
    var body: some View {
        Text("Global environment")
    }
}

struct DebugView: View {

    @Environment(\.dismiss) var dismiss

    let globalItems: [GlobalItem] = [
        GlobalItem(name: "Networking Environment", value: "unknown", type: .networking)
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
            .navigationDestination(for: GlobalItem.self) { listItem in
                switch listItem.type {
                case .networking: NetworkingApiClientChooser()
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

enum ItemType {
    case networking
}

struct GlobalItem: Hashable {
    let name: String
    let value: String
    let type: ItemType
}

