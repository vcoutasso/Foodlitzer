import FirebaseAuth

final class FirebaseAuthenticationService: RemoteAuthenticationServiceProtocol {
    // MARK: - Private properties

    private var authStateListener: AuthStateDidChangeListenerHandle?
    private lazy var defaultAuth = Auth.auth()

    // MARK: - Computed variables

    var isUserSignedIn: Bool {
        defaultAuth.currentUser != nil
    }

    // MARK: - Object lifecycle

    init(stateChangeCallback: @escaping (AppUser?) -> Void) {
        registerStateListener(callback: stateChangeCallback)
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

    func createAccount(with name: String,
                       email: String,
                       password: String,
                       completion: @escaping (AuthenticationResult) -> Void) {
        defaultAuth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else {
                completion(.failure(.unknown))
                return
            }

            if let authResult = authResult {
                self.updateDisplayName(with: name) { error in
                    if error == nil {
                        completion(.success(self.appUser(from: authResult.user)))
                    } else {
                        completion(.failure(.unknown))
                    }
                }
            } else if let error = (error as NSError?) {
                debugPrint("Error trying to create account: \(error.localizedDescription)")

                switch AuthErrorCode(rawValue: error.code) {
                case .invalidEmail:
                    completion(.failure(.invalidEmail))
                case .weakPassword:
                    completion(.failure(.invalidPassword))
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }

    func editAccount(with name: String, email: String, completion: @escaping (AuthenticationResult) -> Void) {
        // TODO: - Create method
    }

    private func updateDisplayName(with name: String, completion: @escaping (Error?) -> Void) {
        if let currentUser = defaultAuth.currentUser {
            let changeRequest = currentUser.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                if let nsError = (error as NSError?) {
                    debugPrint("Error trying to update display name: \(nsError.localizedDescription)")
                }

                currentUser.reload { reloadError in
                    if reloadError != nil {
                        debugPrint("Error trying to updated cached user data")
                    }

                    completion(error)
                }
            }
        }
    }

    func signOut() {
        do {
            try defaultAuth.signOut()
        } catch {
            debugPrint("Error trying to sign out: \(error.localizedDescription)")
        }
    }

    func resetPassword() {
        if let email = defaultAuth.currentUser?.email {
            defaultAuth.sendPasswordReset(withEmail: email) { error in
                if let nsError = (error as NSError?) {
                    debugPrint("Error trying to reset password: \(nsError.localizedDescription)")
                }
            }
        } else {
            debugPrint("Error trying to reset password: User not signed in.")
        }
    }

    // MARK: - Helper methods

    private func registerStateListener(callback: @escaping (AppUser?) -> Void) {
        if let handle = authStateListener {
            defaultAuth.removeStateDidChangeListener(handle)
        }

        authStateListener = defaultAuth.addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }

            callback(self.appUser(from: user))
        }
    }

    private func appUser(from user: User?) -> AppUser? {
        guard let user = user else { return nil }

        return AppUser(id: user.uid, name: user.displayName ?? "N/A", email: user.email ?? "N/A")
    }
}
