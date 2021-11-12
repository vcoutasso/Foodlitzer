import FirebaseAuth

protocol BackendAuthenticationServiceProtocol {
    var isAuthenticated: Bool { get }

    func execute(email: String, password: String, completion: @escaping () -> Void)

    func signOut()
}

final class SignInUseCase: BackendAuthenticationServiceProtocol {
    // MARK: - Private Atributes

    let auth = Auth.auth()
    var isAuthenticated: Bool { auth.currentUser != nil }

    // MARK: - Public Methods

    func execute(email: String, password: String, completion: @escaping () -> Void) {
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

    func signOut() { // TODO: Isso não pode estar aqui futuramente!
        try? auth.signOut()
    }
}
