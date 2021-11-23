@testable import Foodlitzer
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

        func createAccount(with name: String,
                           email: String,
                           password: String,
                           completion: @escaping (AuthenticationResult) -> Void) {}

        func signOut() {}

        func resetPassword() {}
    }

    // MARK: - Unit tests
}
