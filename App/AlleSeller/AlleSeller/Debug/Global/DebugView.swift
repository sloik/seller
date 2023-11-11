
import Foundation
import SwiftUI
import UIKit
import Observation

struct DebugView: View {
    @Environment(\.dismiss) var dismiss

    @State private var globalItems: [Item] = []

    @State private var currentNetworkingEnv: ApiClientFactory.Environment = .production

    @State private var path = NavigationPath()

    let networkingInfoProvider = DebugNetworkingInfoProvider()

    var body: some View {

        NavigationStack(path: $path) {
            List {
                Section(header: HeaderView(text: "🌐 Global")) {
                    ForEach(globalItems, id: \.name) { listItem in
                        NavigationLink(value: listItem) {

                            switch listItem.destination {
                            case .networking:
                                NetworkingRow(
                                    title: listItem.name,
                                    currentEnvironment: $currentNetworkingEnv
                                )
                            }
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
                case .networking:
                    NetworkingApiClientChooser(
                        currentEnv: $currentNetworkingEnv,
                        infoProvider: networkingInfoProvider
                    )
                }
            }
        }
        .onAppear {
            refreshItems()
        }
    }

    private func refreshItems() {
        currentNetworkingEnv = networkingInfoProvider.environment

        globalItems = [
            Item(
                name: "Networking",
                destination: .networking
            ),
        ]
    }
}

private extension DebugView {
    struct Item: Hashable {

        let name: String

        enum Destination: Equatable, Hashable {
            case networking
        }
        let destination: Destination
    }
}
