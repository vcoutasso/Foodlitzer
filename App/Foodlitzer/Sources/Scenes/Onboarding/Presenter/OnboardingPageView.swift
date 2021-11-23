import SwiftUI

struct OnboardingPageView: View {
    let pageNumber: Int

    var body: some View {
        VStack {
            SignWithAppleButtonView()
            ButtonsOnboadingView(text: "Continue with phone number") {
                SignInView(viewModel: SignInViewModelFactory.make())
            }
            Rectangle()
                .frame(width: 64, height: 2)
                .background(Color.black)
            ButtonsOnboadingView(text: "Create new account") {
                RegisterView(viewModel: RegisterViewModelFactory.make())
            }

        }.ignoresSafeArea()
            .background(Color.white)
    }
}

#if DEBUG
    struct OnboardingPageView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingPageView(pageNumber: 0)
        }
    }
#endif
