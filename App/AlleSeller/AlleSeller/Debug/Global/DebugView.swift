
import Foundation
import SwiftUI
import Observation

import Seller

struct DebugView: View {
    @Environment(\.dismiss) var dismiss

    @State private var debugFeatures: DebugFeaturesModel = .init()

    @State private var globalItems: [Item] = []

    @State private var path = NavigationPath()

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
                                    currentEnvironment: $debugFeatures.appEnvironment
                                )
                            }
                        }
                    }
                }

                Section(header: HeaderView(text: "🏃🏻‍♂️ Actions")) {

                    Button("Force Refresh Token") {
                        Task {
                            try? await CurrentSeller.refreshToken()
                        }
                    }

                }
            #if os(iOS)
                .listStyle(InsetGroupedListStyle())
            #endif
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
                        currentEnv: $debugFeatures.appEnvironment
                    )
                }
            }
        }
        .onAppear {
            refreshItems()
        }
    }

    private func refreshItems() {
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
