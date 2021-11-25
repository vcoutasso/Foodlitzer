@testable import SpiderVerse
import XCTest

final class SignInViewModelTests: XCTestCase {
    // MARK: - System under test

    private let authenticationServiceSpy = AuthenticationServiceSpy()
    private lazy var sut = SignInViewModel(authenticationService: authenticationServiceSpy)

    // MARK: - Test doubles

    final class AuthenticationServiceSpy: AuthenticationServiceProtocol {
        var appUser: AppUser?

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

    func testIsButtonDisabledShouldBeTrueWhenEmailIsEmpty() {
        // Given
        sut.password = "password"
        sut.email = ""

        // When / Then
        XCTAssert(sut.isButtonDisabled)
    }

    func testIsButtonDisabledShouldBeTrueWhenPasswordIsEmpty() {
        // Given
        sut.password = ""
        sut.email = "email"

        // When / Then
        XCTAssert(sut.isButtonDisabled)
    }

    func testIsButtonDisabledShouldBeFalseWhenFieldsAreNotEmpty() {
        // Given
        sut.password = "password"
        sut.email = "email"

        // When / Then
        XCTAssertFalse(sut.isButtonDisabled)
    }

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

    /*
     func testUpdateSignedInStatusShouldPromptOnFailure() {
         // Given
         let isAuthenticatedStub = false
         authenticationServiceSpy.isUserSignedIn = isAuthenticatedStub
         let expectedResult = true

         // When
         sut.updateSignedInStatus()

         // Then
         XCTAssertEqual(sut.shouldPromptInvalidCredentials, expectedResult)
     }

     func testUpdateSignedInStatusShouldNotPromptOnSuccess() {
         // Given
         let isAuthenticatedStub = true
         backendServiceSpy.isAuthenticated = isAuthenticatedStub
         let expectedResult = false

         // When
         sut.updateSignedInStatus()

         // Then
         XCTAssertEqual(sut.shouldPromptInvalidCredentials, expectedResult)
     }

     func testUpdateSignedInStatusShouldPresentProfileOnSuccess() {
         // Given
         let isAuthenticatedStub = true
         backendServiceSpy.isAuthenticated = isAuthenticatedStub
         let expectedResult = true

         // When
         sut.updateSignedInStatus()

         // Then
         XCTAssertEqual(sut.shouldPresentProfileView, expectedResult)
     }
     */
}
