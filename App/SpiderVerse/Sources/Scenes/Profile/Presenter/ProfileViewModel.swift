import Foundation

protocol ProfileViewModelProtocol: ObservableObject {
    var userName: String? { get }
    var userEmail: String? { get }

    func logOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    // MARK: - Published Atributes

    @Published var userName: String?
    @Published var userEmail: String?

    // MARK: - Private Atributes

    private var userDetails: UserProfileDetails? { sessionService.userDetails }
    private let sessionService: SessionServiceProtocol

    // MARK: - Object Lifecycle

    init(sessionService: SessionServiceProtocol) {
        self.sessionService = sessionService

        let currentUser = sessionService.getCurrentUser()
        self.userName = currentUser?.name
        self.userEmail = currentUser?.email
    }

    // MARK: - Public Method

    func logOut() {
        sessionService.logOut()
    }
}

// MARK: - View Model Factory

enum ProfileViewModelFactory {
    static func make() -> ProfileViewModel {
        ProfileViewModel(sessionService: SessionServiceUseCase())
    }
}
