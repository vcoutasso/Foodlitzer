@testable import SpiderVerse
import XCTest

final class RegisterViewModelTests: XCTestCase {
    // MARK: - System under test

    private let authenticationServiceDummy = AuthenticationServiceDummy()
    private lazy var sut = RegisterViewModel(authenticationService: authenticationServiceDummy)

    // MARK: - Test doubles

    final class AuthenticationServiceDummy: AuthenticationServiceProtocol {
        var appUser: AppUser?

        var isUserSignedIn: Bool = false

        func signIn(withEmail email: String,
                    password: String,
                    completion: @escaping (AuthenticationResult) -> Void) {}

        func createAccount(withEmail email: String,
                           password: String,
                           completion: @escaping (AuthenticationResult) -> Void) {}

        func updateDisplayName(with name: String, completion: @escaping (Error?) -> Void) {}

        func signOut() {}

        func resetPassword() {}
    }

    // MARK: - Unit tests
}
