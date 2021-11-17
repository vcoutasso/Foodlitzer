import SwiftUI

struct SignInView<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType
    @State private var showRegisterView = false
    @State private var showResetPasswordView = false
    @State private var isShowingProfileView = false

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
                showResetPasswordView.toggle()
            }

            Button {
                // FIXME: Sign In está clicavel e entrando na home mesmo quando os dados estão incorretos.
                viewModel.signIn()
                // isShowingProfileView.toggle()
            } label: {
                Text(Localizable.SignIn.SignInButton.text)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
            .disabled(viewModel.isButtonDisabled)
            .padding(.vertical, 16)

            Button {
                showRegisterView.toggle()

            } label: {
                Text(Localizable.SignIn.RegisterButton.text)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
        }
        .padding()
        .sheet(isPresented: $showRegisterView) {
            let viewModel = RegisterViewModel(emailValidationService: ValidateEmailUseCase(),
                                              passwordValidationService: ValidatePasswordUseCase(),
                                              backendService: BackendUserCreationService())
            RegisterView(viewModel: viewModel)
        }
        .sheet(isPresented: $showResetPasswordView) {
            ForgotPasswordView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService()))
        }
        .sheet(isPresented: $isShowingProfileView) {
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
