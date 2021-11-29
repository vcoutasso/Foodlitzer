import SwiftUI

struct OnboardingBottomView: View {
    let pageNumber: Int

    var body: some View {
        VStack {
//            SignWithAppleButtonView()
            ButtonsOnboadingView(text: Localizable.SignIn.SignInButtonMessage.placeholder) {
                SignInView(viewModel: SignInViewModelFactory.make())
            }
            Rectangle()
                .frame(width: 64, height: 2)
                .background(Color.black)
            ButtonsOnboadingView(text: Localizable.SignIn.RegisterButton.text) {
                RegisterView(viewModel: RegisterViewModelFactory.make())
            }

        }.ignoresSafeArea()
            .background(Color(Assets.Colors.backgroundGray))
    }
}

#if DEBUG
    struct OnboardingBottomView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingBottomView(pageNumber: 0)
        }
    }
#endif
