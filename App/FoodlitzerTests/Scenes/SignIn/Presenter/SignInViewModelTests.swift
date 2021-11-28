@testable import Foodlitzer
import XCTest

final class SignInViewModelTests: XCTestCase {
    // MARK: - System under test

    private let authenticationServiceSpy = AuthenticationServiceSpy()
    private lazy var sut = SignInViewModel(authenticationService: authenticationServiceSpy)

    // MARK: - Test doubles

    final class AuthenticationServiceSpy: AuthenticationServiceProtocol {
        func editAccount(with name: String, email: String, completion: @escaping (AuthenticationResult) -> Void) {}

        var currentUser: AppUser?

        var isUserSignedIn: Bool = false

        private(set) var signInCalled = false
        func signIn(withEmail email: String,
                    password: String,
                    completion: @escaping (AuthenticationResult) -> Void) {
            signInCalled = true
        }

        // swiftlint:disable all
        func createAccount(with name: String, email: String, password: String,
                           completion: @escaping (AuthenticationResult) -> Void) {
            fatalError("Not implemented")
        }

        func signOut() {
            fatalError("Not implemented")
        }

        func resetPassword() {
            fatalError("Not implemented")
        }
        // swiftlint:enable all
    }

    // MARK: - Unit tests

    func testHandleSignInButtonTappedShouldCallServiceSignIn() {
        // Given
        let expectedResult = true

        // When
        sut.handleSignInButtonTapped()

        // Then
        XCTAssertEqual(authenticationServiceSpy.signInCalled, expectedResult)
    }

    func testRegisterButtonTappedShouldSetPresentRegistrationView() {
        // Given
        sut.shouldPresentRegistrationView = false
        let expectedResult = true

        // When
        sut.handleRegisterButtonTapped()

        // Then
        XCTAssertEqual(sut.shouldPresentRegistrationView, expectedResult)
    }

    func testForgotPasswordButtonTappedShouldSetPresentResetPasswordView() {
        // Given
        sut.shouldPresentResetPasswordView = false
        let expectedResult = true

        // When
        sut.handleForgotPasswordButtonTapped()

        // Then
        XCTAssertEqual(sut.shouldPresentResetPasswordView, expectedResult)
    }
}
