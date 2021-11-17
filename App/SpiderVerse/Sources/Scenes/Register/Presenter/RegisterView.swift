import SwiftUI

struct RegisterView<ViewModelType>: View where ViewModelType: RegisterViewModelProtocol {
    @StateObject var viewModel: ViewModelType

    var body: some View {
        VStack {
            TextField(Localizable.Register.Name.placeholder, text: $viewModel.nameText)
                .padding()
                .background(Color(.secondarySystemBackground))

            TextField(Localizable.Register.Email.placeholder, text: $viewModel.emailText)
                .padding()
                .background(Color(.secondarySystemBackground))

            TextField(Localizable.Register.Password.placeholder, text: $viewModel.passwordText)
                .padding()
                .background(Color(.secondarySystemBackground))

            TextField(Localizable.Register.ConfirmPassword.placeholder, text: $viewModel.confirmPasswordText)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button {
                // FIXME: Precisa mostrar quais são os requisitos ou o que está sendo negado para a criação de conta, além disso não está indo direto para a "home" quando a conta é criada
                viewModel.register()
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
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            let emailValidator = ValidateEmailUseCase()
            let passwordValidator = ValidatePasswordUseCase()
            RegisterView(viewModel: RegisterViewModel(emailValidationService: emailValidator,
                                                      passwordValidationService: passwordValidator,
                                                      backendService: BackendUserCreationService()))
        }
    }
#endif
