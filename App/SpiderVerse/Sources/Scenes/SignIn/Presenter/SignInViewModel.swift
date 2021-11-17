import Foundation

protocol SignInViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var shouldPresentProfileView: Bool { get set }
    var shouldPresentRegistrationView: Bool { get set }
    var shouldPresentResetPasswordView: Bool { get set }
    var isButtonDisabled: Bool { get }

    func handleSignInButtonTapped()
    func handleRegisterButtonTapped()
    func handleForgotPasswordButtonTapped()
}

final class SignInViewModel: SignInViewModelProtocol {
    // MARK: - Published Atributes

    @Published var email: String
    @Published var password: String
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
        self.shouldPresentProfileView = false
        self.shouldPresentRegistrationView = false
        self.shouldPresentResetPasswordView = false
        self.backendAuthenticationService = backendAuthService
        self.isSignedIn = backendAuthService.isAuthenticated
    }

    // MARK: - Event Methods

    func handleSignInButtonTapped() {
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

    private func updateSignedInStatus() {
        isSignedIn = backendAuthenticationService.isAuthenticated
        shouldPresentProfileView = isSignedIn
    }
}
