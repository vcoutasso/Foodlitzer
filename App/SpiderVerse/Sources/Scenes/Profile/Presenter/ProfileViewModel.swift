import Foundation

protocol ProfileViewModelProtocol: ObservableObject {
    var userName: String? { get }
    var userEmail: String? { get }
    func signOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    // MARK: - Published Atributes

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
    }

    // MARK: - Public Method

    func signOut() {
        authenticationService.signOut()
        objectWillChange.send()
    }
}

// MARK: - View Model Factory

enum ProfileViewModelFactory {
    static func make() -> ProfileViewModel {
        ProfileViewModel(authenticationService: AuthenticationService())
    }
}
