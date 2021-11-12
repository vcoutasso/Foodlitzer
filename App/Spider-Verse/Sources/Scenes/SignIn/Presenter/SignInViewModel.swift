import Foundation

protocol SignInViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isButtonDisabled: Bool { get }
    var backendAuthenticationService: BackendAuthenticationServiceProtocol { get set }
    var isSignedIn: Bool { get set }

    func signIn()
    func logOut()
}

final class SignInViewModel: SignInViewModelProtocol {
    // MARK: - Published Atributes

    @Published var email: String
    @Published var password: String
    @Published var isSignedIn: Bool

    // MARK: - Computed Variables

    var isButtonDisabled: Bool { email.isEmpty || password.isEmpty }

    // MARK: - Private Atributes

    internal var backendAuthenticationService: BackendAuthenticationServiceProtocol

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
            DispatchQueue.main.async {
                self?.objectWillChange.send()
            }
        }
    }

    func logOut() {
        backendAuthenticationService.signOut()
        clearFields()
        objectWillChange.send()
    }

    // MARK: - Helper Methods

    private func clearFields() {
        email = ""
        password = ""
    }
}
