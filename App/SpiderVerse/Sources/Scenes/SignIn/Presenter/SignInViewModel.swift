import FirebaseAuth

protocol SignInViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isButtonDisabled: Bool { get }
    var isSignedIn: Bool { get }

    func signIn()
    func logOut()
}

final class SignInViewModel: SignInViewModelProtocol {
    // MARK: - Published Atributes

    @Published var email: String
    @Published var password: String

    // MARK: - Computed Variables

    var isButtonDisabled: Bool { email.isEmpty || password.isEmpty }
    var isSignedIn: Bool { auth.currentUser != nil }

    // MARK: - Private Atributes

    private let auth = Auth.auth()

    // MARK: - Object Lifecycle

    init() {
        self.email = ""
        self.password = ""
    }

    // MARK: - Public Methods

    func signIn() {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil else {
                if let error = error {
                    debugPrint("Could not Sign in. Error: '\(error)'")
                }
                return
            }

            DispatchQueue.main.async {
                self?.objectWillChange.send()
            }
        }
    }

    func logOut() {
        try? auth.signOut()
        clearFields()
        objectWillChange.send()
    }

    // MARK: - Helper Methods

    private func clearFields() {
        email = ""
        password = ""
    }
}
