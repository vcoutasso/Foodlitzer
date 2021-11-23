import Foundation

protocol ForgotPasswordViewModelProtocol: ObservableObject {
    var email: String { get set }

    func sendPasswordReset()
}

final class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    // MARK: - Published variables

    @Published var email: String

    // MARK: - Dependencies

    private var authenticationService: AuthenticationServiceProtocol

    init(authenticationService: AuthenticationServiceProtocol) {
        self.email = ""
        self.authenticationService = authenticationService
    }

    func sendPasswordReset() {
        authenticationService.resetPassword()
    }
}

// MARK: - View Model Factory

enum ForgotPasswordViewModelFactory {
    static func make() -> ForgotPasswordViewModel {
        ForgotPasswordViewModel(authenticationService: AuthenticationService.shared)
    }
}
