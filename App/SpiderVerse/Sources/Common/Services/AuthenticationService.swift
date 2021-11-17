import FirebaseAuth

// TODO: Move this stuff outta here

typealias AuthenticationResult = Result<AppUser, AuthenticationError>

protocol AuthenticationServiceProtocol {
    var currentUser: User? { get }
    var isUserSignedIn: Bool { get }

    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationResult) -> Void)

    func createAccount(withEmail email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void)
    func signOut()
}

enum AuthenticationError: Error {
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case unknown
}

final class AuthenticationService: AuthenticationServiceProtocol {
    // MARK: - Properties

    var currentUser: User?

    var isUserSignedIn: Bool {
        currentUser != nil
    }

    // MARK: - Private properties

    private var authStateListener: AuthStateDidChangeListenerHandle?
    private let defaultAuth = Auth.auth()

    // MARK: - Object lifecycle

    init() {
        registerStateListener()
    }

    // MARK: - Authentication methods

    // TODO: Refactor to avoid duplication
    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationResult) -> Void) {
        defaultAuth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            var result: AuthenticationResult = .failure(.unknown)

            if let authResult = authResult {
                result = .success(self.appUser(from: authResult.user))
            } else if let error = (error as NSError?) {
                debugPrint("Error trying to sign in: \(error.localizedDescription)")

                switch AuthErrorCode(rawValue: error.code) {
                case .userNotFound, .wrongPassword:
                    result = .failure(.invalidCredentials)
                default:
                    result = .failure(.unknown)
                }
            }

            completion(result)
        }
    }

    func createAccount(withEmail email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void) {
        defaultAuth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            var result: AuthenticationResult = .failure(.unknown)

            if let authResult = authResult {
                result = .success(self.appUser(from: authResult.user))
            } else if let error = (error as NSError?) {
                debugPrint("Error trying to create account: \(error.localizedDescription)")

                switch AuthErrorCode(rawValue: error.code) {
                case .invalidEmail:
                    result = .failure(.invalidEmail)
                case .weakPassword:
                    result = .failure(.invalidPassword)
                default:
                    result = .failure(.unknown)
                }
            }

            completion(result)
        }
    }

    func signOut() {
        do {
            try defaultAuth.signOut()
        } catch {
            debugPrint("Error trying to sign out: \(error.localizedDescription)")
        }
    }

    // MARK: - Helper methods

    private func registerStateListener() {
        if let handle = authStateListener {
            defaultAuth.removeStateDidChangeListener(handle)
        }

        authStateListener = defaultAuth.addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }

            if let user = user {
                self.currentUser = user
            }
        }
    }

    // FIXME: Empty strings should not be allowed
    private func appUser(from user: User) -> AppUser {
        AppUser(id: user.uid, name: user.displayName ?? "", email: user.email ?? "")
    }
}
