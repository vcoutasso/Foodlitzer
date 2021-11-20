import SwiftUI

struct RegisterView<ViewModelType>: View where ViewModelType: RegisterViewModelProtocol {
    // MARK: - Attributes

    @StateObject var viewModel: ViewModelType

    // MARK: - Views

    var body: some View {
        VStack {
            nameField

            emailField

            passwordField

            confirmPasswordField

            registerButton
        }
        .padding()
    }

    private var nameField: some View {
        TextField(Localizable.Register.Name.placeholder, text: $viewModel.nameText)
            .padding()
            .background(Color(.secondarySystemBackground))
            .autocapitalization(.words)
    }

    private var emailField: some View {
        TextField(Localizable.Register.Email.placeholder, text: $viewModel.emailText)
            .padding()
            .background(Color(.secondarySystemBackground))
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .overlay(Rectangle()
                .stroke(lineWidth: 1)
                .foregroundColor(viewModel.shouldPromptInvalidEmail ? .red : .clear))
    }

    private var passwordField: some View {
        SecureField(Localizable.Register.Password.placeholder, text: $viewModel.passwordText)
            .padding()
            .background(Color(.secondarySystemBackground))
            .overlay(Rectangle()
                .stroke(lineWidth: 1)
                .foregroundColor(viewModel.shouldPromptInvalidPassword ? .red : .clear))
    }

    private var confirmPasswordField: some View {
        SecureField(Localizable.Register.ConfirmPassword.placeholder, text: $viewModel.confirmPasswordText)
            .padding()
            .background(Color(.secondarySystemBackground))
            .overlay(Rectangle()
                .stroke(lineWidth: 1)
                .foregroundColor(viewModel.shouldPromptPasswordMismatch ? .red : .clear))
    }

    private var registerButton: some View {
        Button {
            viewModel.handleRegisterButtonTapped()
        } label: {
            Text(Localizable.SignUp.CreateAccountButton.text)
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(Color.black)
        }
        .padding()
    }
}

#if DEBUG
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView(viewModel: RegisterViewModelFactory.make())
        }
    }
#endif
