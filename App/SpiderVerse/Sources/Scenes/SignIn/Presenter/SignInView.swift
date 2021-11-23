import SwiftUI

// TODO: Extract this into specialized views (custom modifiers maybe?)
private enum LayoutMetrics {
    static let buttonWidth: CGFloat = 310
    static let buttonHeight: CGFloat = 40
    static let buttonPadding: CGFloat = 16
}

struct SignInView<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    // MARK: - Attributes

    @EnvironmentObject private var authenticationService: AuthenticationService
    @ObservedObject private(set) var viewModel: ViewModelType

    // MARK: - Views

    var body: some View {
        VStack {
            signInText

            emailField

            passwordField

            if viewModel.shouldPromptInvalidCredentials {
                invalidCredentials
            }

            forgotPasswordButton

            signInButton

            registerButton

            NavigationLink(isActive: $viewModel.didSignIn,
                           destination: { PlacesListView(viewModel: PlacesListViewModelFactory.make()) },
                           label: { EmptyView() })
        }.halfSheet(showSheet: $viewModel.shouldPresentResetPasswordView) {
            ForgotPasswordView(viewModel: ForgotPasswordViewModel(authenticationService: authenticationService))
        }
    }

    private var signInText: some View {
        VStack {
            Text("Sign In")
                .font(.custom("Lora-Regular", size: 36))
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum quis tortor facilisis.")
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .light))
                .frame(width: 300, height: 83, alignment: .center)
                .padding(.bottom, 20)
        }
    }

    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(Color("iconsGray"))
            TextField(Localizable.SignIn.Email.placeholder, text: $viewModel.email)
                .frame(width: 309)
                .font(.system(size: 18, weight: .regular))
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
        }.underlineTextField()
    }

    private var passwordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(Color("iconsGray"))
            SecureField(Localizable.SignIn.Password.placeholder, text: $viewModel.password)
                .frame(width: 309)
        }.underlineTextField()
    }

    private var invalidCredentials: some View {
        Text(Localizable.SignIn.InvalidCredentials.prompt)
            .padding()
            .foregroundColor(.red)
    }

    private var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button(Localizable.SignIn.ForgotPassword.placeholder) {
                viewModel.handleForgotPasswordButtonTapped()
            }
            .font(.system(size: 14, weight: .light))
            .foregroundColor(.black)

        }.padding(20)
    }

    private var signInButton: some View {
        Button {
            viewModel.handleSignInButtonTapped()
        } label: {
            Text(Localizable.SignIn.SignInButton.text)
                .frame(width: LayoutMetrics.buttonWidth, height: LayoutMetrics.buttonHeight)
                .foregroundColor(.white)
                .background(Color.black)
        }
        .disabled(viewModel.isButtonDisabled)
        .padding(.vertical, LayoutMetrics.buttonPadding)
    }

    private var registerButton: some View {
        HStack {
            Text("DON'T HAVE AN ACCOUNT YET?")
                .font(.system(size: 12, weight: .light))
            OpenRegisterView {
                RegisterView(viewModel: RegisterViewModelFactory.make())
                    .onAppear {
                        viewModel.handleRegisterButtonTapped()
                    }.navigationBarHidden(true)
            }

        }.padding(.top, 15)
    }
}

extension View {
    func underlineTextField() -> some View {
        padding(.vertical, 20)
            .overlay(Rectangle()
                .strokeBorder(lineWidth: 0.2)
                .frame(height: 1)
                .padding(.top, 35))
            .foregroundColor(.black)
    }
}

#if DEBUG
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView(viewModel: SignInViewModel(authenticationService: AuthenticationService.shared))
        }
    }
#endif
