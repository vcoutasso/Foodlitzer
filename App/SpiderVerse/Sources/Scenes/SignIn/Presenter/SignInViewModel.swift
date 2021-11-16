import Foundation

protocol SignInViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isButtonDisabled: Bool { get }

    func signIn()
}

final class SignInViewModel: SignInViewModelProtocol {
    // MARK: - Published Atributes

    @Published var email: String
    @Published var password: String
    @Published var isSignedIn: Bool

    // MARK: - Computed Variables

    var isButtonDisabled: Bool { email.isEmpty || password.isEmpty }

    // MARK: - Private Atributes

    private let backendAuthenticationService: BackendAuthenticationServiceProtocol

    // MARK: - Object Lifecycle

    init(backendAuthService: BackendAuthenticationServiceProtocol) {
        self.email = ""
        self.password = ""
        self.backendAuthenticationService = backendAuthService
        self.isSignedIn = backendAuthService.isAuthenticated
    }

    // MARK: - Public Methods

    func signIn() {
        backendAuthenticationService.execute(email: email, password: password) { [weak self] in
            guard let this = self else { return }
            this.updateSignedInStatus()
        }
    }

    // MARK: - Helper Methods

    private func updateSignedInStatus() {
        isSignedIn = backendAuthenticationService.isAuthenticated
    }
}
