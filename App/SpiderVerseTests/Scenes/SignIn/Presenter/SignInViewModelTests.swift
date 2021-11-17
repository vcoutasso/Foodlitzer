@testable import SpiderVerse
import XCTest

final class SignInViewModelTests: XCTestCase {
    // MARK: - System under test

    private let backendServiceSpy = BackendAuthenticationServiceSpy()
    private lazy var sut = SignInViewModel(backendAuthService: backendServiceSpy)

    // MARK: - Test doubles

    final class BackendAuthenticationServiceSpy: BackendAuthenticationServiceProtocol {
        var isAuthenticated: Bool = false

        private(set) var executeCalled: Bool = false
        func execute(email: String, password: String, completion: @escaping () -> Void) {
            executeCalled = true
        }
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

    func testHandleSignInButtonTappedShouldCallBackendServiceExecute() {
        // Given
        let expectedResult = true

        // When
        sut.handleSignInButtonTapped()

        // Then
        XCTAssertEqual(backendServiceSpy.executeCalled, expectedResult)
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

    func testUpdateSignedInStatusShouldPromptOnFailure() {
        // Given
        let isAuthenticatedStub = false
        backendServiceSpy.isAuthenticated = isAuthenticatedStub
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
}
