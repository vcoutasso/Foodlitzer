import Combine

protocol ProfileViewModelProtocol: ObservableObject {
    var userName: String? { get }
    var userEmail: String? { get }
    func signOut()
    func delete()
    func editAccount(with name: String, and email: String, completion: @escaping () -> Void)
}

final class ProfileViewModel: ProfileViewModelProtocol {
    // MARK: - Published Atributes

    var userName: String? {
        authenticationService.currentUser?.name
    }

    var userEmail: String? {
        authenticationService.currentUser?.email
    }

    // MARK: - Dependencies

    private let authenticationService: AuthenticationServiceProtocol

    // MARK: - Object Lifecycle

    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }

    // MARK: - Public Method

    func signOut() {
        authenticationService.signOut()
        objectWillChange.send()
    }

    func delete() {
        // TODO: - Delete Method
    }

    func editAccount(with name: String, and email: String, completion: @escaping () -> Void) {
        guard let newName = name.isEmpty ? userName : name,
              let newEmail = email.isEmpty ? userEmail : email
        else { return }

        authenticationService.editAccount(with: newName, email: newEmail) { [weak self] error in
            if let error = error {
                debugPrint("Could not edit account: \(error.localizedDescription)")
            }
            completion()
            self?.objectWillChange.send()
        }
    }
}

// MARK: - View Model Factory

enum ProfileViewModelFactory {
    static func make() -> ProfileViewModel {
        ProfileViewModel(authenticationService: AuthenticationService.shared)
    }
}
