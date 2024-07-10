
import SwiftUI

import Lentil

struct LoginView: View {

    @Bindable var model: MyAccountViewModel

    public var body: some View {
        VStack(spacing: 0) {
            String.localized("seller")
            Spacer()
            String.localized("required_account_1")
                .frame(maxWidth: .infinity, alignment: .leading)
                .design(typography: .bigTitle(weight: .heavy))
            String.localized("required_account_2")
                .frame(maxWidth: .infinity, alignment: .leading)
                .design(typography: .bigTitle(weight: .heavy))
            Spacer()
            Button(action: {
                model.didTapLogin()
            }, label: {
                String.localized("log_in")
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

            Text(String.localized("login_terms_1"))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(String.localized("login_terms_2"))\(Text("[\(String.localized("login_terms_3"))](https://www.google.com/)").underline()) \(Text(String.localized("login_terms_4")))")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 34)
            Text("[\(String.localized("terms_and_conditions"))](https://www.google.com/)").underline()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 34)
        }
        .padding(.horizontal, 16)
    }
}
