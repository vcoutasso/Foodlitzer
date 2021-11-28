import SwiftUI

// TODO: Extract this into specialized views (custom modifiers maybe?)

private enum LayoutMetrics {
    static let buttonWidth: CGFloat = 310
    static let buttonHeight: CGFloat = 40
    static let buttonPadding: CGFloat = 16
}

struct SignInView<ViewModelType>: View where ViewModelType: SignInViewModelProtocol {
    @State var editingEmail = false
    @State var editingPassword = false
    @State var fade = false
    @FocusState private var isTextFieldFocused: Bool
    @Namespace var buttonPosion

    // MARK: - Attributes

    @ObservedObject private(set) var viewModel: ViewModelType

    // MARK: - Views

    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                VStack(spacing: 10) {
                    signInText

                    emailField

                    passwordField

                    forgotPasswordButton

                    signInButton
                        .id(buttonPosion)
                        .onChange(of: editingEmail || isTextFieldFocused) { _ in
                            withAnimation {
                                value.scrollTo(buttonPosion)
                            }
                        }

                    registerButton
                }
                .halfSheet(showSheet: $viewModel.shouldPresentResetPasswordView) {
                    ForgotPasswordView(viewModel: ForgotPasswordViewModelFactory.make())
                }
            }
            .onTapGesture {
                self.hideKeyboard()
            }
        }
    }

    private var signInText: some View {
        VStack(spacing: 35) {
            Text(Localizable.SignIn.SignInButton.text)
                .font(.lora(.regular, size: 36))
                .padding(.bottom, 35)

            Text(Localizable.SignIn.Subtitle.text)
                .largeTextDisplay()
        }
    }

    private var emailField: some View {
        ZStack {
            HStack {
                Image(systemName: Strings.Symbols.email)
                    .foregroundColor(Color.black.opacity(0.3))

                TextField(Localizable.SignIn.Email.placeholder, text: $viewModel.email) { change in
                    withAnimation {
                        editingEmail = change
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80)
                .font(.system(size: 18, weight: .regular))
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            }
            .padding(.bottom, 5)
            .overlay(bottomLine())
            .underlineTextField(isEditing: editingEmail)

            if viewModel.shouldPromptInvalidCredentials {
                XMark(fade: $fade, set: $viewModel.shouldPromptInvalidCredentials)
            }
        }
    }

    private var passwordField: some View {
        ZStack {
            HStack {
                Image(systemName: Strings.Symbols.password)
                    .foregroundColor(Color.black.opacity(0.3))

                SecureField(Localizable.SignIn.Password.placeholder, text: $viewModel.password)
                    .focused($isTextFieldFocused)
                    .frame(width: UIScreen.main.bounds.width - 80)
            }
            .overlay(bottomLine())
            .font(.system(size: 18, weight: .regular))
            .underlineTextField(isEditing: isTextFieldFocused)

            if viewModel.shouldPromptInvalidCredentials {
                XMark(fade: $fade, set: $viewModel.shouldPromptInvalidCredentials)
            }
        }
    }

    private var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button(Localizable.SignIn.ForgotPassword.placeholder) {
                viewModel.handleForgotPasswordButtonTapped()
            }
            .font(.system(size: 14, weight: .light))
            .foregroundColor(.black)
        }
        .padding(.trailing, 40)
        .padding(.bottom, 90)
    }

    private var signInButton: some View {
        Button {
            viewModel.handleSignInButtonTapped()
        } label: {
            Text(Localizable.SignIn.SignInButton.text)
                .font(.sfCompactText(.regular, size: 14))
                .frame(width: UIScreen.main.bounds.width - 60, height: LayoutMetrics.buttonHeight)
                .foregroundColor(viewModel.isButtonDisabled ? .black.opacity(0.3) : .white)
                .background(viewModel.isButtonDisabled ? Color.white : Color.black)
        }
        .buttonDisableAnimation(state: viewModel.isButtonDisabled)
    }

    private var registerButton: some View {
        HStack {
            Text(Localizable.SignIn.SignUp.text)
                .font(.sfCompactText(.light, size: 12))
            OpenRegisterView {
                RegisterView(viewModel: RegisterViewModelFactory.make())
                    .onAppear {
                        viewModel.handleRegisterButtonTapped()
                    }
            }
        }
    }
}
