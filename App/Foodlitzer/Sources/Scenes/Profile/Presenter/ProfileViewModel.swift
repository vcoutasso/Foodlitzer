import Foundation

protocol ProfileViewModelProtocol: ObservableObject {
    var editingName: String { get set }
    var editingEmail: String { get set }
    var userName: String? { get }
    var userEmail: String? { get }
    func signOut()
    func delete()
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
        authenticationService.editAccount(with: editingName, email: editingEmail) { _ in
        }
    }
}

// MARK: - View Model Factory

enum ProfileViewModelFactory {
    static func make() -> ProfileViewModel {
        ProfileViewModel(authenticationService: AuthenticationService.shared)
    }
}
