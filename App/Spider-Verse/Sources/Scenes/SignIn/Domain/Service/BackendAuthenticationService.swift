import FirebaseAuth

protocol BackendAuthenticationServiceProtocol {
    var isAuthenticated: Bool { get }

    func execute(email: String, password: String, completion: @escaping () -> Void)
}

final class SignInUseCase: BackendAuthenticationServiceProtocol {
    // MARK: - Private Atributes

    let auth = Auth.auth()
    var isAuthenticated: Bool { auth.currentUser != nil }

    // MARK: - Public Methods

    func execute(email: String, password: String, completion: @escaping () -> Void) { // async await
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil else {
                if let error = error {
                    debugPrint("Could not Sign in. Error: '\(error)'")
                }
                return
            }
            completion()
        }
    }
}
