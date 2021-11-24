import SwiftUI

private enum LayoutMetrics {
    static let buttonWidth: CGFloat = 310
    static let buttonHeight: CGFloat = 40
    static let buttonPadding: CGFloat = 16
}

struct RegisterView<ViewModelType>: View where ViewModelType: RegisterViewModelProtocol {
    // MARK: - Attributes

    @ObservedObject private(set) var viewModel: ViewModelType

    // MARK: - Views

    var body: some View {
        VStack {
            signUpText

            nameField

            emailField

            passwordField

            confirmPasswordField

            signUpButton

            registerButton
        }
    }

    private var signUpText: some View {
        VStack {
            Text("Sign Up")
                .font(.custom("Lora-Regular", size: 36))
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum quis tortor facilisis.")
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .light))
                .frame(width: 300, height: 83, alignment: .center)
                .padding(.bottom, 20)
        }
    }

    private var nameField: some View {
        HStack {
            Image(systemName: "person")
                .foregroundColor(Color("iconsGray"))
            TextField(Localizable.Register.Name.placeholder, text: $viewModel.nameText)
                .frame(width: 309)
                .autocapitalization(.words)
        }.underlineTextField()
    }

    private var emailField: some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(Color("iconsGray"))
            TextField(Localizable.Register.Email.placeholder, text: $viewModel.emailText)
                .frame(width: 309)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .overlay(Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(viewModel.shouldPromptInvalidEmail ? .red : .clear))
        }.underlineTextField()
    }

    private var passwordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(Color("iconsGray"))
            SecureField(Localizable.Register.Password.placeholder, text: $viewModel.passwordText)
                .frame(width: 309)
                .overlay(Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(viewModel.shouldPromptInvalidPassword ? .red : .clear))
        }.underlineTextField()
    }

    private var confirmPasswordField: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(Color("iconsGray"))
            SecureField(Localizable.Register.ConfirmPassword.placeholder, text: $viewModel.confirmPasswordText)
                .frame(width: 309)
                .overlay(Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(viewModel.shouldPromptPasswordMismatch ? .red : .clear))
        }.underlineTextField()
    }

    private var signUpButton: some View {
        Button {
            viewModel.handleRegisterButtonTapped()
        } label: {
            Text("Sign Up")
                .frame(width: LayoutMetrics.buttonWidth, height: LayoutMetrics.buttonHeight)
                .foregroundColor(.white)
                .background(Color.black)
        }
        .disabled(viewModel.isButtonDisabled)
        .padding(.vertical, LayoutMetrics.buttonPadding)
    }

    private var registerButton: some View {
        HStack {
            Text("ALREADY HAVE AN ACCOUNT?")
                .font(.system(size: 12, weight: .light))

            OpenSignInView {
                SignInView(viewModel: SignInViewModelFactory.make())
                    .onAppear {
                        viewModel.handleRegisterButtonTapped()
                    }.navigationBarHidden(true)
            }
        }
    }
}

#if DEBUG
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView(viewModel: RegisterViewModelFactory.make())
        }
    }
#endif
