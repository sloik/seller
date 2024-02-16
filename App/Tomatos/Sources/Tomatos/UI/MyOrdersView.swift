// system
import SwiftUI

import ComposableArchitecture

struct MyOrdersView {

    private let store: StoreOf<OrdersFeature>

    init(store: StoreOf<OrdersFeature>) {
        self.store = store
    }
}

extension MyOrdersView: View {
    public var body: some View {
        
        VStack() {
            Text("My orders")

            ScrollView {

                ForEach(store.forms) { form in
                    VStack {
                        FormView(form: form)
                    }
                }

            }

        }
        .onAppear {
            store.send(.refreshOrdersList)
        }
    }
}

#Preview {
    MyOrdersView(
        store: Store(
            initialState: OrdersFeature.State()
        ) {}
    )
}

struct FormView: View {

    let form: CheckoutForm

    var body: some View {
        "\(form.buyer.login)"

        HStack {
            
            BostonImageView()

            VStack {
                form.buyer.firstName ?? "-"
                form.buyer.lastName ?? "-"

            }

        }
    }
}

struct BostonImageView: View {
    var body: some View {
        AsyncImage(
            url: URL(string:  "https://previews.123rf.com/images/denisdore/denisdore1109/denisdore110900007/10629857-male-baby-boston-terrier-on-white-vertical.jpg")!,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}
