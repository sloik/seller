
import SwiftUI

import Lentil

struct LoginView: View {

    @Bindable var model: MyAccountViewModel

    public var body: some View {
        VStack {
            VStack(spacing: 0) {
                "Wymagane konto"
                    .design(typography: .bigTitle(weight: .heavy))
                   // .frame(width: infinity, alignment: .leading)
                "Sprzedawcy Allegro"
                    .design(typography: .bigTitle(weight: .heavy))
              //      .frame(width: infinity, alignment: .leading)

            }
            .frame(maxWidth: .infinity, alignment: .leading)


           "Przystępując do logowania,"
           "akceptujesz warunki użytkowania z aplikacji Seller."

           "Warunki użytkowania"
           // .frame(width: .infinity, alignment: .leading)
            Button("Login", action: model.didTapLogin)
                .sheet(isPresented: $model.loginWebViewIsPresented) {

                    Lentil
                        .loginUI(didLogin: model.didLogin)
#if os(macOS)
                        .design(sheet: .regular)
#endif
                }
        }
    }
}
