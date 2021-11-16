import SwiftUI

struct SignInView<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    @ObservedObject var viewModel: ViewModelType
    @State private var showSignUpView = false
    @State private var showResetPasswordView = false
    @State private var isShowingProfileView = false

    var body: some View {
        VStack {
            TextField("E-mail Adress", text: $viewModel.email)
                .padding()
                .background(Color(.secondarySystemBackground))

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button("Forgot Password?") {
                showResetPasswordView.toggle()
            }

            Button {
                // FIXME: Sign In está clicavel e entrando na home mesmo quando os dados estão incorretos. Anteriormente estava com navigation link, porém o metodo sigIn não estava implementado, tornando impossível de atualizar a view com os dados do usuário.
                viewModel.signIn()
                isShowingProfileView.toggle()
            } label: {
                Text("Sign In")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
            .disabled(viewModel.isButtonDisabled)
            .padding(.vertical, 16)

            Button {
                showSignUpView.toggle()

            } label: {
                Text("Sign UP")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
        }
        .padding()
        .sheet(isPresented: $showSignUpView) {
            let viewModel = SignUpViewModel(emailValidationService: ValidateEmailUseCase(),
                                            passwordValidationService: ValidatePasswordUseCase(),
                                            backendService: BackendUserCreationService())
            SignUpView(viewModel: viewModel)
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
