
import SwiftUI

import Lentil

struct LoginView: View {

    @Bindable var model: MyAccountViewModel

    public var body: some View {
        VStack(spacing: 0) {
            "Seller"
            Spacer()
            "Wymagane konto"
                .frame(maxWidth: .infinity, alignment: .leading)
                .design(typography: .bigTitle(weight: .heavy))
            "Sprzedawcy Allegro"
                .frame(maxWidth: .infinity, alignment: .leading)
                .design(typography: .bigTitle(weight: .heavy))
            Spacer()
            Button(action: {
                model.didTapLogin()
            }, label: {
                "Zaloguj się"
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 24,
                            style: .circular
                        )
                        .fill(.pink)
                    )
            })
            .sheet(isPresented: $model.loginWebViewIsPresented) {

                Lentil
                    .loginUI(didLogin: model.didLogin)
#if os(macOS)
                    .design(sheet: .regular)
#endif
            }
            Spacer()

            Text("Przystępując do logowania,")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("akceptujesz \(Text("[warunki użytkowania](https://www.google.com/)").underline()) \(Text("z aplikacji Seller."))")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 34)
            Text("[Warunki użytkowania](https://www.google.com/)").underline()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 34)
        }
        .padding(.horizontal, 16)
    }
}
