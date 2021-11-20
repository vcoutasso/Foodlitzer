import FirebaseAuth

typealias AuthenticationResult = Result<AppUser?, AuthenticationError>

protocol AuthenticationServiceProtocol: BackendServiceProtocol {
    var appUser: AppUser? { get }
    var isUserSignedIn: Bool { get }
}

enum AuthenticationError: Error {
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case unknown
}

// TODO: Review if both currentUser and appUser are necessary (or even a good idea)
final class AuthenticationService: AuthenticationServiceProtocol, ObservableObject {
    // MARK: - Singleton

    static let shared = AuthenticationService()

    // MARK: - Dependencies

    private lazy var backendService: BackendServiceProtocol = {
        FirebaseService(stateChangeCallback: backendUpdateCallback)
    }()

    // MARK: - Properties

    var appUser: AppUser?

    var isUserSignedIn: Bool {
        appUser != nil
    }

    private lazy var backendUpdateCallback: (AppUser?) -> Void = { [weak self] user in
        self?.appUser = user
    }

    // MARK: - Object lifecycle

    private init() {}

    // MARK: - Authentication methods

    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationResult) -> Void) {
        backendService.signIn(withEmail: email, password: password, completion: completion)
    }

    func createAccount(withEmail email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void) {
        backendService.createAccount(withEmail: email, password: password, completion: completion)
    }

    func updateDisplayName(with name: String, completion: @escaping (Error?) -> Void) {
        backendService.updateDisplayName(with: name, completion: completion)
    }

    func signOut() {
        backendService.signOut()
        objectWillChange.send()
    }

    func resetPassword() {
        backendService.resetPassword()
    }
}
