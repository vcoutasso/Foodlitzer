import FirebaseAuth

final class FirebaseAuthenticationService: RemoteAuthenticationServiceProtocol {
    // MARK: - Private properties

    private var authStateListener: AuthStateDidChangeListenerHandle?
    private lazy var defaultAuth = Auth.auth()

    // MARK: - Computed variables

    var currentUser: AppUser? {
        currentUser(from: defaultAuth.currentUser)
    }

    var isUserSignedIn: Bool {
        defaultAuth.currentUser != nil
    }

    // MARK: - Object lifecycle

    init(stateChangeCallback: @escaping (AppUser?) -> Void) {
        registerStateListener(callback: stateChangeCallback)
    }

    // MARK: - Authentication methods

    func signIn(withEmail email: String,
                password: String,
                completion: @escaping (AuthenticationError?) -> Void) {
        defaultAuth.signIn(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                completion(nil)
            } else if let error = (error as NSError?) {
                debugPrint("Error signing in: \(error.localizedDescription)")

                switch AuthErrorCode(rawValue: error.code) {
                case .userNotFound, .wrongPassword:
                    completion(.invalidCredentials)
                default:
                    completion(.unknown)
                }
            } else {
                completion(.unknown)
            }
        }
    }

    func createAccount(with name: String,
                       email: String,
                       password: String,
                       completion: @escaping (AuthenticationError?) -> Void) {
        defaultAuth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else {
                completion(.unknown)
                return
            }

            if authResult != nil {
                self.updateDisplayName(with: name) { error in
                    if error == nil {
                        completion(nil)
                    } else {
                        completion(.unknown)
                    }
                }
            } else if let error = (error as NSError?) {
                debugPrint("Error trying to create account: \(error.localizedDescription)")

                switch AuthErrorCode(rawValue: error.code) {
                case .invalidEmail:
                    completion(.invalidEmail)
                case .weakPassword:
                    completion(.invalidPassword)
                default:
                    completion(.unknown)
                }
            } else {
                completion(.unknown)
            }
        }
    }

    func editAccount(with name: String, email: String, completion: @escaping (AuthenticationError?) -> Void) {
        guard let currentUser = defaultAuth.currentUser else {
            completion(.userNotLoggedIn)
            return
        }

        updateDisplayName(with: name) { error in
            guard error == nil else {
                completion(.unknown)
                return
            }

            currentUser.updateEmail(to: email) { error in
                guard error == nil else {
                    debugPrint("Error updating user email: \(error!.localizedDescription)")
                    completion(.unknown)
                    return
                }

                currentUser.reload { reloadError in
                    if let error = reloadError {
                        debugPrint("Error updating cached user data: \(error.localizedDescription)")
                    }

                    completion(nil)
                }
            }
        }
    }

    private func updateDisplayName(with name: String, completion: @escaping (Error?) -> Void) {
        guard let currentUser = defaultAuth.currentUser else { return }

        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { error in
            if let error = error {
                debugPrint("Error updating display name: \(error.localizedDescription)")
            }

            currentUser.reload { reloadError in
                if let error = reloadError {
                    debugPrint("Error updating cached user data: \(error.localizedDescription)")
                }

                completion(error)
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

            callback(self.currentUser(from: user))
        }
    }

    private func currentUser(from user: User?) -> AppUser? {
        guard let user = user else { return nil }

        return AppUser(id: user.uid, name: user.displayName ?? "N/A", email: user.email ?? "N/A")
    }
}
