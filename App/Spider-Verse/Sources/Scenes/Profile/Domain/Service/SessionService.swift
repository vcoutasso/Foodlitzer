import Firebase
import FirebaseAuth
import Foundation

enum SessionState {
    case loggedIn
    case loggedOut
}

protocol SessionServiceProtocol {
    var state: SessionState { get }
    var userDetails: UserProfileDetails? { get }

    func logOut()
}

final class SessionServiceUseCase: ObservableObject, SessionServiceProtocol {
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: UserProfileDetails?

    private var handler: AuthStateDidChangeListenerHandle?

    init() {
        setupFirebaseAuthHandler()
    }

    func logOut() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceUseCase {
    func setupFirebaseAuthHandler() {
        handler = Auth
            .auth()
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
                      let name = value[RegistrationKeys.name.rawValue] as? String,
                      let email = value[RegistrationKeys.email.rawValue] as? String else { return }

                DispatchQueue.main.async {
                    this.userDetails = UserProfileDetails(name: name, email: email)
                }
            }
    }
}
