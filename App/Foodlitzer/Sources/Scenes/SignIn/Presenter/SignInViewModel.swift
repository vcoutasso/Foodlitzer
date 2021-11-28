import Combine

protocol SignInViewModelProtocol: ObservableObject {
    // User input
    var email: String { get set }
    var password: String { get set }
    // Presentation logic
    var shouldPromptInvalidCredentials: Bool { get set }
    var shouldPresentProfileView: Bool { get set }
    var shouldPresentRegistrationView: Bool { get set }
    var shouldPresentResetPasswordView: Bool { get set }
    var isButtonDisabled: Bool { get }

    // Handle events
    func handleSignInButtonTapped()
    func handleRegisterButtonTapped()
    func handleForgotPasswordButtonTapped()
}

final class SignInViewModel: SignInViewModelProtocol {
    // MARK: - Published Atributes

    @Published var email: String
    @Published var password: String
    @Published var shouldPromptInvalidCredentials: Bool
    @Published var shouldPresentProfileView: Bool
    @Published var shouldPresentRegistrationView: Bool
    @Published var shouldPresentResetPasswordView: Bool

    // MARK: - Computed Variables

    var isButtonDisabled: Bool { email.isEmpty || password.isEmpty || shouldPromptInvalidCredentials }

    // MARK: - Private Atributes

    private let authenticationService: AuthenticationServiceProtocol

    // MARK: - Object Lifecycle

    init(authenticationService: AuthenticationServiceProtocol) {
        self.email = ""
        self.password = ""
        self.shouldPromptInvalidCredentials = false
        self.shouldPresentProfileView = false
        self.shouldPresentRegistrationView = false
        self.shouldPresentResetPasswordView = false
        self.authenticationService = authenticationService
    }

    // MARK: - Event Methods

    func handleSignInButtonTapped() {
        resetFlags()

        authenticationService.signIn(withEmail: email, password: password) { [weak self] error in
            self?.signInCallback(error: error)
        }
    }

    func handleRegisterButtonTapped() {
        shouldPresentRegistrationView = true
    }

    func handleForgotPasswordButtonTapped() {
        shouldPresentResetPasswordView = true
    }

    // MARK: - Helper Methods

    private func resetFlags() {
        shouldPromptInvalidCredentials = false
        shouldPresentProfileView = false
        shouldPresentRegistrationView = false
        shouldPresentResetPasswordView = false
    }

    private func signInCallback(error: AuthenticationError?) {
        if error != nil {
            shouldPromptInvalidCredentials = true
        } else {
            shouldPresentProfileView = true
        }
    }
}

enum SignInViewModelFactory {
    static func make() -> SignInViewModel {
        .init(authenticationService: AuthenticationService.shared)
    }
}
