import Foundation

protocol SignInViewModelProtocol: ObservableObject {
    // User input
    var email: String { get set }
    var password: String { get set }
    // Presentation logic
    var shouldPromptInvalidCredentials: Bool { get }
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

    var isButtonDisabled: Bool { email.isEmpty || password.isEmpty }

    // MARK: - Private Atributes

    private let backendAuthenticationService: BackendAuthenticationServiceProtocol
    private var isSignedIn: Bool

    // MARK: - Object Lifecycle

    init(backendAuthService: BackendAuthenticationServiceProtocol) {
        self.email = ""
        self.password = ""
        self.shouldPromptInvalidCredentials = false
        self.shouldPresentProfileView = false
        self.shouldPresentRegistrationView = false
        self.shouldPresentResetPasswordView = false
        self.backendAuthenticationService = backendAuthService
        self.isSignedIn = backendAuthService.isAuthenticated
    }

    // MARK: - Event Methods

    func handleSignInButtonTapped() {
        shouldPromptInvalidCredentials = false
        backendAuthenticationService.execute(email: email, password: password) { [weak self] in
            guard let this = self else { return }
            this.updateSignedInStatus()
        }
    }

    func handleRegisterButtonTapped() {
        shouldPresentRegistrationView = true
    }

    func handleForgotPasswordButtonTapped() {
        shouldPresentResetPasswordView = true
    }

    // MARK: - Helper Methods

    func updateSignedInStatus() {
        isSignedIn = backendAuthenticationService.isAuthenticated
        shouldPresentProfileView = isSignedIn
        if !isSignedIn {
            shouldPromptInvalidCredentials = true
        }
    }
}
