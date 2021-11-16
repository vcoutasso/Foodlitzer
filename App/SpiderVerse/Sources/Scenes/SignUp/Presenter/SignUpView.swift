import SwiftUI

struct SignUpView<ViewModelType>: View where ViewModelType: SignUpViewModelProtocol {
    @StateObject var viewModel: ViewModelType

    var body: some View {
        VStack {
            TextField(Localizable.SignUp.Name.placeholder, text: $viewModel.nameText)
                .padding()
                .background(Color(.secondarySystemBackground))

            TextField(Localizable.SignUp.Email.placeholder, text: $viewModel.emailText)
                .padding()
                .background(Color(.secondarySystemBackground))

            TextField(Localizable.SignUp.Password.placeholder, text: $viewModel.passwordText)
                .padding()
                .background(Color(.secondarySystemBackground))

            TextField(Localizable.SignUp.ConfirmPassword.placeholder, text: $viewModel.confirmPasswordText)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button {
                // FIXME: Precisa mostrar quais são os requisitos ou o que está sendo negado para a criação de conta, além disso não está indo direto para a "home" quando a conta é criada
                viewModel.signUp()
            } label: {
                Text("Sign UP")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
            }
            .padding()
        }
        .padding()
    }
}

#if DEBUG
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            let emailValidator = ValidateEmailUseCase()
            let passwordValidator = ValidatePasswordUseCase()
            SignUpView(viewModel: SignUpViewModel(emailValidationService: emailValidator,
                                                  passwordValidationService: passwordValidator,
                                                  backendService: BackendUserCreationService()))
        }
    }
#endif
