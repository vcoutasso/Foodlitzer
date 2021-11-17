import SwiftUI

// TODO: Find a better way to do this
private enum LayoutMetrics {
    static let buttonWidth: CGFloat = 200
    static let buttonHeight: CGFloat = 50
    static let buttonPadding: CGFloat = 16
}

struct SignInView<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    // MARK: - Attributes

    @ObservedObject var viewModel: ViewModelType

    // MARK: - Views

    var body: some View {
        VStack {
            emailField

            passwordField

            if viewModel.shouldPromptInvalidCredentials {
                invalidCredentials
            }

            forgotPasswordButton

            signInButton

            registerButton
        }
        .padding()
        .sheet(isPresented: $viewModel.shouldPresentRegistrationView) {
            RegisterView(viewModel: RegisterViewModelFactory.make())
        }
        .sheet(isPresented: $viewModel.shouldPresentResetPasswordView) {
            ForgotPasswordView(viewModel: ForgotPasswordViewModelFactory.make())
        }
        .sheet(isPresented: $viewModel.shouldPresentProfileView) {
            ProfileView(viewModel: ProfileViewModelFactory.make())
        }
    }

    private var emailField: some View {
        TextField(Localizable.SignIn.Email.placeholder, text: $viewModel.email)
            .padding()
            .background(Color(.secondarySystemBackground))
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
    }

    private var passwordField: some View {
        SecureField(Localizable.SignIn.Password.placeholder, text: $viewModel.password)
            .padding()
            .background(Color(.secondarySystemBackground))
    }

    private var invalidCredentials: some View {
        Text(Localizable.SignIn.InvalidCredentials.prompt)
            .padding()
            .foregroundColor(.red)
    }

    private var forgotPasswordButton: some View {
        Button(Localizable.SignIn.ForgotPassword.placeholder) {
            viewModel.handleForgotPasswordButtonTapped()
        }
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
        Button {
            viewModel.handleRegisterButtonTapped()
        } label: {
            Text(Localizable.SignIn.RegisterButton.text)
                .frame(width: LayoutMetrics.buttonWidth, height: LayoutMetrics.buttonHeight)
                .foregroundColor(.white)
                .background(Color.black)
        }
    }
}

#if DEBUG
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView(viewModel: SignInViewModel(backendAuthService: SignInUseCase()))
        }
    }
#endif
