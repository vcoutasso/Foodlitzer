import Foundation

protocol ProfileViewModelProtocol: ObservableObject {
    var userName: String? { get }
    var userEmail: String? { get }

    func logOut()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    @Published var userName: String?
    @Published var userEmail: String?

    private var userDetails: UserProfileDetails? {
        sessionService.userDetails
    }

    private let sessionService: SessionServiceProtocol

    init(sessionService: SessionServiceProtocol) {
        self.sessionService = sessionService

        let currentUser = sessionService.getCurrentUser()
        self.userName = currentUser?.name
        self.userEmail = currentUser?.email
    }

    func logOut() {
        sessionService.logOut()
    }
}
