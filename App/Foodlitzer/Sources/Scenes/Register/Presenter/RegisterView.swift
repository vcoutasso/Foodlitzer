import SwiftUI

private enum LayoutMetrics {
    static let buttonWidth: CGFloat = 310
    static let buttonHeight: CGFloat = 40
    static let buttonPadding: CGFloat = 16
}

struct RegisterView<ViewModelType>: View where ViewModelType: RegisterViewModelProtocol {
    // MARK: - Attributes

    @Environment(\.presentationMode) var presentation
    @ObservedObject private(set) var viewModel: ViewModelType
    @Namespace var buttonPosion

    // MARK: - Views

    var body: some View {
        ScrollView {
            ScrollViewReader { _ in
                VStack(spacing: 0) {
                    signUpText

                    nameField

                    emailField

                    passwordField

                    confirmPasswordField

                    signUpButton
                        .id(buttonPosion)
//                        .onChange(of: editingEmail || isTextFieldFocused == true) { _ in
//                            withAnimation {
//                                value.scrollTo(buttonPosion)
//                            }
//                        }

                    registerButton
                }
            }
        }
    }

    private var signUpText: some View {
        VStack {
            Text(Localizable.SignUp.CreateAccountButton.text)
                .font(.lora(.regular, fixedSize: 36))
                .padding(.bottom, 35)

            Text(Localizable.SignUp.Subtitle.text)
                .multilineTextAlignment(.center)
                .lineSpacing(15)
                .font(.sfCompactText(.light, size: 14))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 35)
                .padding(.horizontal, 40)
        }
    }

    private var nameField: some View {
        HStack {
            Image(systemName: Strings.Symbols.person)
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            TextField(Localizable.Register.Name.placeholder, text: $viewModel.nameText)
                .frame(width: UIScreen.main.bounds.width - 80)
                .autocapitalization(.words)
        }
        .underlineTextField(isEditing: false)
        .padding(.bottom, 0)
    }

    private var emailField: some View {
        HStack {
            Image(systemName: Strings.Symbols.email)
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            TextField(Localizable.Register.Email.placeholder, text: $viewModel.emailText)
                .frame(width: UIScreen.main.bounds.width - 80)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .overlay(Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(viewModel.shouldPromptInvalidEmail ? .red : .clear))
        }
        .underlineTextField(isEditing: false)
        .padding(.bottom, 0)
    }

    private var passwordField: some View {
        HStack {
            Image(systemName: Strings.Symbols.password)
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            SecureField(Localizable.Register.Password.placeholder, text: $viewModel.passwordText)
                .frame(width: UIScreen.main.bounds.width - 80)
                .overlay(Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(viewModel.shouldPromptInvalidPassword ? .red : .clear))
        }
        .underlineTextField(isEditing: false)
        .padding(.bottom, 0)
    }

    private var confirmPasswordField: some View {
        HStack {
            Image(systemName: Strings.Symbols.password)
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            SecureField(Localizable.Register.ConfirmPassword.placeholder, text: $viewModel.confirmPasswordText)
                .frame(width: UIScreen.main.bounds.width - 80)
                .overlay(Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(viewModel.shouldPromptPasswordMismatch ? .red : .clear))
        }
        .underlineTextField(isEditing: false)
        .padding(.bottom, 115)
    }

    private var signUpButton: some View {
        Button {
            viewModel.handleRegisterButtonTapped()
        } label: {
            Text(Localizable.SignUp.CreateAccountButton.text)
                .frame(width: LayoutMetrics.buttonWidth, height: LayoutMetrics.buttonHeight)
                .foregroundColor(.white)
                .background(Color.black)
        }
        .disabled(viewModel.isButtonDisabled)
        .padding(.bottom, 40)
    }

    private var registerButton: some View {
        HStack {
            Text(Localizable.SignUp.SignIn.text)
                .font(.system(size: 12, weight: .light))

            OpenSignInView {
                SignInView(viewModel: SignInViewModelFactory.make())
                    .onAppear {
                        viewModel.handleRegisterButtonTapped()
                    }
            }
        }
        .padding(.bottom, 40)
    }
}

#if DEBUG
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView(viewModel: RegisterViewModelFactory.make())
        }
    }
#endif
