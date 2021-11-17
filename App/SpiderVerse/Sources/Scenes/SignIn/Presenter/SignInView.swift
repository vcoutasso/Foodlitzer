import SwiftUI

struct SignInView<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType

    var body: some View {
        VStack {
            TextField(Localizable.SignIn.Email.placeholder, text: $viewModel.email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField(Localizable.SignIn.Password.placeholder, text: $viewModel.password)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button(Localizable.SignIn.ForgotPassword.placeholder) {
                viewModel.handleForgotPasswordButtonTapped()
            }

            Button {
                // TODO: Let the user know the credentials are invalid
                viewModel.handleSignInButtonTapped()
            } label: {
                Text(Localizable.SignIn.SignInButton.text)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
            .disabled(viewModel.isButtonDisabled)
            .padding(.vertical, 16)

            Button {
                viewModel.handleRegisterButtonTapped()
            } label: {
                Text(Localizable.SignIn.RegisterButton.text)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.shouldPresentRegistrationView) {
            let viewModel = RegisterViewModel(emailValidationService: ValidateEmailUseCase(),
                                              passwordValidationService: ValidatePasswordUseCase(),
                                              backendService: BackendUserCreationService())
            RegisterView(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.shouldPresentResetPasswordView) {
            ForgotPasswordView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService()))
        }
        .sheet(isPresented: $viewModel.shouldPresentProfileView) {
            ProfileView(viewModel: ProfileViewModel(sessionService: SessionServiceUseCase()))
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
