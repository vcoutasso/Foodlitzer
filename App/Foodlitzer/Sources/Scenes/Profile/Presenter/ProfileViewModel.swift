import Foundation

protocol ProfileViewModelProtocol: ObservableObject {
    var editingName: String { get set }
    var editingEmail: String { get set }
    var userName: String? { get }
    var userEmail: String? { get }
    func signOut()
    func delete()
    func editAccount()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    // MARK: - Published Atributes

    @Published var editingName: String
    @Published var editingEmail: String

    var userName: String? {
        authenticationService.appUser?.name
    }

    var userEmail: String? {
        authenticationService.appUser?.email
    }

    // MARK: - Dependencies

    private let authenticationService: AuthenticationServiceProtocol

    // MARK: - Object Lifecycle

    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
        self.editingName = authenticationService.appUser?.name ?? ""
        self.editingEmail = authenticationService.appUser?.email ?? ""
    }

    // MARK: - Public Method

    func signOut() {
        authenticationService.signOut()
        objectWillChange.send()
    }

    func delete() {
        // TODO: - Delete Method
    }

    func editAccount() {
        guard let newName = editingName.isEmpty ? userName : editingName,
              let newEmail = editingEmail.isEmpty ? userEmail : editingEmail
        else { return }

        authenticationService.editAccount(with: newName, email: newEmail) { result in
            switch result {
            case let .failure(error):
                debugPrint("Could not edit account: \(error.localizedDescription)")
            case let .success(user):
                print("user: \(user!.name), email: \(user!.email)")
            }
        }
    }
}

// MARK: - View Model Factory

enum ProfileViewModelFactory {
    static func make() -> ProfileViewModel {
        ProfileViewModel(authenticationService: AuthenticationService.shared)
    }
}
