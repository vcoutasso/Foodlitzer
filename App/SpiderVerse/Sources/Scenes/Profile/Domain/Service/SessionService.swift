import Firebase
import FirebaseAuth
import Foundation

protocol SessionServiceProtocol {
    var state: Session.State { get }
    var userDetails: UserProfileDetails? { get }

    func getCurrentUser() -> UserProfileDetails?
    func logOut()
}

final class SessionServiceUseCase: SessionServiceProtocol {
    // MARK: - Published Atributes

    @Published var state: Session
        .State = .loggedOut
    var userDetails: UserProfileDetails?

    // MARK: - Private Atribute

    private var handler: AuthStateDidChangeListenerHandle?
    private let auth = Auth.auth()

    // MARK: - Object Lifecycle

    init() {
        setupFirebaseAuthHandler()
    }

    // MARK: - Public Methods

    func logOut() {
        try? Auth.auth().signOut()
    }

    func getCurrentUser() -> UserProfileDetails? {
        guard let currentUser = auth.currentUser else { return nil }

        // FIXME: resolver o unwrap, displayName não mostra nome do usuário
        return UserProfileDetails(name: currentUser.displayName ?? "n/a", email: currentUser.email ?? "n/a")
    }
}

// MARK: - Session Extension Methods

private extension SessionServiceUseCase {
    func setupFirebaseAuthHandler() {
        handler = auth
            .addStateDidChangeListener { [weak self] _, user in
                guard let this = self else { return }
                this.state = user == nil ? .loggedOut : .loggedIn

                if let uid = user?.uid {
                    this.handleRefresh(with: uid)
                }
            }
    }

    func handleRefresh(with uid: String) {
        Database
            .database()
            .reference()
            .child("users")
            .child(uid)
            .observe(.value) { [weak self] snapshot in

                guard let this = self,
                      let value = snapshot.value as? NSDictionary,
                      let name = value[Registration.Keys.name.rawValue] as? String,
                      let email = value[Registration.Keys.email.rawValue] as? String else { return }

                DispatchQueue.main.async {
                    this.userDetails = UserProfileDetails(name: name, email: email)
                }
            }
    }
}
