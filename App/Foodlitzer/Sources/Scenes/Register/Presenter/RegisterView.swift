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

    @State var editingName = false
    @State var editingEmail = false
    @State var fade = false
    @FocusState private var isTextFieldFocusedPass: Bool
    @FocusState private var isTextFieldFocusedConf: Bool

    // MARK: - Views

    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                VStack(spacing: 0) {
                    signUpText

                    nameField

                    emailField

                    passwordField

                    confirmPasswordField

                    signUpButton
                        .id(buttonPosion)
                        .onChange(of: viewModel.nameText) { _ in
                            withAnimation {
                                value.scrollTo(buttonPosion)
                            }
                        }

                    registerButton
                }
                .padding(.horizontal, 30)
            }
        }
    }

    private var signUpText: some View {
        VStack {
            Text(Localizable.SignUp.CreateAccountButton.text)
                .font(.lora(.regular, fixedSize: 36))
                .padding(.bottom, 35)

            Text(Localizable.SignUp.Subtitle.text)
                .largeTextDisplay()
        }
    }

    private var nameField: some View {
        HStack {
            Image(systemName: Strings.Symbols.person)
                .foregroundColor(Color(Assets.Colors.unavailableGray))
            TextField(Localizable.Register.Name.placeholder, text: $viewModel.nameText) { change in
                editingName = change
            }
            .frame(width: UIScreen.main.bounds.width - 80)
            .autocapitalization(.words)
        }
        .underlineTextField(isEditing: editingName)
        .padding(.bottom, 0)
    }

    private var emailField: some View {
        ZStack {
            HStack {
                Image(systemName: Strings.Symbols.email)
                    .foregroundColor(Color(Assets.Colors.unavailableGray))
                TextField(Localizable.Register.Email.placeholder, text: $viewModel.emailText) { change in
                    editingEmail = change
                }
                .frame(width: UIScreen.main.bounds.width - 80)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            }
            .padding(.bottom, 0)
            .underlineTextField(isEditing: editingEmail)

            if viewModel.invalidAttempt {
                XMark(fade: $fade, set: $viewModel.invalidAttempt)
            }
        }
    }

    private var passwordField: some View {
        ZStack {
            HStack {
                Image(systemName: Strings.Symbols.password)
                    .foregroundColor(Color(Assets.Colors.unavailableGray))
                SecureField(Localizable.Register.Password.placeholder, text: $viewModel.passwordText)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .focused($isTextFieldFocusedPass)
            }
            .underlineTextField(isEditing: isTextFieldFocusedPass)
            .padding(.bottom, 0)

            if viewModel.invalidAttempt {
                XMark(fade: $fade, set: $viewModel.invalidAttempt)
            }
        }
    }

    private var confirmPasswordField: some View {
        ZStack {
            HStack {
                Image(systemName: Strings.Symbols.password)
                    .foregroundColor(Color(Assets.Colors.unavailableGray))
                SecureField(Localizable.Register.ConfirmPassword.placeholder, text: $viewModel.confirmPasswordText)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .focused($isTextFieldFocusedConf)
            }
            .underlineTextField(isEditing: isTextFieldFocusedConf)

            if viewModel.invalidAttempt {
                XMark(fade: $fade, set: $viewModel.invalidAttempt)
            }
        }
        .padding(.bottom, 50)
    }

    private var signUpButton: some View {
        Button {
            viewModel.handleRegisterButtonTapped()
        } label: {
            Text(Localizable.SignUp.CreateAccountButton.text)
                .frame(width: LayoutMetrics.buttonWidth, height: LayoutMetrics.buttonHeight)
                .foregroundColor(viewModel.isButtonDisabled ? .black.opacity(0.3) : .white)
                .background(viewModel.isButtonDisabled ? Color.white : Color.black)
        }
        .buttonDisableAnimation(state: viewModel.isButtonDisabled)
        .padding(.bottom, 10)
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
    }
}
