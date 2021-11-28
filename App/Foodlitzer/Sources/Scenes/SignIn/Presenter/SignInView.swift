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
                        .onChange(of: editingEmail || isTextFieldFocused == true) { _ in
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
                .lineSpacing(15)
                .multilineTextAlignment(.center)
                .font(.compact(.light, size: 14))
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
        }
    }

    private var emailField: some View {
        ZStack {
            HStack {
                Image(systemName: Strings.Symbols.email)
                    .foregroundColor(Color("iconsGray"))

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
            .overlay(Rectangle()
                .frame(width: UIScreen.main.bounds.width - 50, height: 0.3)
                .padding(.top, 34))

            .underlineTextField(isEditing: editingEmail)

            if viewModel.shouldPromptInvalidCredentials {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 18))
                    .foregroundColor(fade ? .black : .clear)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 0.3, alignment: .trailing)
                    .animation(.default, value: fade)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3)) {
                            fade = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                fade = false
                                viewModel.shouldPromptInvalidCredentials = false
                            }
                        }
                    }
            }
        }
    }

    private var passwordField: some View {
        ZStack {
            HStack {
                Image(systemName: Strings.Symbols.password)
                    .foregroundColor(Color("iconsGray"))

                SecureField(Localizable.SignIn.Password.placeholder, text: $viewModel.password)
                    .focused($isTextFieldFocused)
                    .frame(width: UIScreen.main.bounds.width - 80)
            }
            .overlay(Rectangle()
                .frame(width: UIScreen.main.bounds.width - 50, height: 0.3)
                .padding(.top, 34))
            .font(.system(size: 18, weight: .regular))
            .underlineTextField(isEditing: isTextFieldFocused)

            if viewModel.shouldPromptInvalidCredentials {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 18))
                    .foregroundColor(fade ? .black : .clear)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 0.3, alignment: .trailing)
                    .animation(.default, value: fade)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3)) {
                            fade = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                fade = false
                                viewModel.shouldPromptInvalidCredentials = false
                            }
                        }
                    }
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
                .font(.compact(.regular, size: 14))
                .frame(width: UIScreen.main.bounds.width - 60, height: LayoutMetrics.buttonHeight)
                .foregroundColor(viewModel.isButtonDisabled ? .black.opacity(0.3) : .white)
                .background(viewModel.isButtonDisabled ? Color.white : Color.black)
        }
        .disabled(viewModel.isButtonDisabled)
        .border(Color.black.opacity(0.3), width: viewModel.isButtonDisabled ? 0.3 : 0)
        .padding(.vertical, LayoutMetrics.buttonPadding)
        .padding(.bottom, 30)
        .animation(.default, value: viewModel.isButtonDisabled)
    }

    private var registerButton: some View {
        HStack {
            Text(Localizable.SignIn.SignUp.text)
                .font(.compact(.light, size: 12))
            OpenRegisterView {
                RegisterView(viewModel: RegisterViewModelFactory.make())
                    .onAppear {
                        viewModel.handleRegisterButtonTapped()
                    }
            }
        }
    }
}

extension View {
    func underlineTextField(isEditing: Bool) -> some View {
        padding(.vertical, 20)
            .overlay(ZStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 50, height: 0.3)

                Rectangle()
                    .frame(width: isEditing ? UIScreen.main.bounds.width - 50 : 0, height: isEditing ? 1.5 : 0.3)
                    .animation(.default, value: isEditing)
            }
            .padding(.top, 35))
            .foregroundColor(.black)
    }
}
