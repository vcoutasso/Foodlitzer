//
//  OnboardingPageView.swift
//  SpiderVerse
//
//  Created by Vinícius Couto on 16/11/21.
//

import SwiftUI

struct OnboardingPageView: View {
    let pageNumber: Int
    @EnvironmentObject private var authenticationService: AuthenticationService
    var body: some View {
        VStack {
            SignWithAppleButtonView()
            ButtonsOnboadingView(text: "Continue with phone number") {
                SignInView(viewModel: SignInViewModel(authenticationService: authenticationService))
            }
            Rectangle()
                .frame(width: 64, height: 2)
                .background(Color.black)
            ButtonsOnboadingView(text: "Create new account") {
                RegisterView(viewModel: RegisterViewModel(emailValidationService: ValidateEmailUseCase(),
                                                          passwordValidationService: ValidatePasswordUseCase(),
                                                          authenticationService: authenticationService))
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
