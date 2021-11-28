import FirebaseAuth
import Foundation

protocol AuthenticationServiceProtocol: RemoteAuthenticationServiceProtocol {
    var isUserSignedIn: Bool { get }
}

enum AuthenticationError: Error {
    case invalidEmail
    case invalidPassword
    case invalidCredentials
    case userNotLoggedIn
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
        debugPrint("Authentication state did change with user: \(String(describing: user))")
        self?.objectWillChange.send()
    }

    var currentUser: AppUser? {
        backendService.currentUser
    }

    var isUserSignedIn: Bool {
        backendService.isUserSignedIn
    }

    // MARK: - Object lifecycle

    private init() {}

    // MARK: - Authentication methods

    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationError?) -> Void) {
        backendService.signIn(withEmail: email, password: password, completion: completion)
    }

    func createAccount(with name: String,
                       email: String,
                       password: String,
                       completion: @escaping (AuthenticationError?) -> Void) {
        backendService.createAccount(with: name, email: email, password: password) { error in
            completion(error)
        }
    }

    func signOut() {
        backendService.signOut()
    }

    func resetPassword() {
        backendService.resetPassword()
    }

    func editAccount(with name: String,
                     email: String,
                     completion: @escaping (AuthenticationError?) -> Void) {
        backendService.editAccount(with: name, email: email, completion: completion)
    }
}
