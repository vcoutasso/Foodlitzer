import FirebaseAuth

typealias AuthenticationResult = Result<AppUser?, AuthenticationError>

protocol AuthenticationServiceProtocol: RemoteAuthenticationServiceProtocol {
    var appUser: AppUser? { get }
    var isUserSignedIn: Bool { get }
}

enum AuthenticationError: Error {
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case unknown
}

final class AuthenticationService: AuthenticationServiceProtocol, ObservableObject {
    // MARK: - Singleton

    static let shared = AuthenticationService()

    // MARK: - Dependencies

    private lazy var backendService: RemoteAuthenticationServiceProtocol = {
        FirebaseAuthenticationService(stateChangeCallback: backendUpdateCallback)
    }()

    // MARK: - Properties

    private lazy var backendUpdateCallback: (AppUser?) -> Void = { [weak self] user in
        self?.appUser = user
        self?.objectWillChange.send()
    }

    var appUser: AppUser?

    var isUserSignedIn: Bool {
        backendService.isUserSignedIn
    }

    // MARK: - Object lifecycle

    private init() {}

    // MARK: - Authentication methods

    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationResult) -> Void) {
        backendService.signIn(withEmail: email, password: password, completion: completion)
    }

    func createAccount(with name: String,
                       email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void) {
        backendService.createAccount(with: name, email: email, password: password) { [weak self] result in
            if case let .success(user) = result {
                self?.updateCurrentUser(with: user)
            }

            completion(result)
        }
    }

    private func updateCurrentUser(with user: AppUser?) {
        appUser = user
    }

    func signOut() {
        backendService.signOut()
    }

    func resetPassword() {
        backendService.resetPassword()
    }

    func editAccount(with name: String,
                     email: String,
                     completion: @escaping (AuthenticationResult) -> Void) {}
}
