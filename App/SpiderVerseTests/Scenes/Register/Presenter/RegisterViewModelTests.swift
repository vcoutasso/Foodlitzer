@testable import SpiderVerse
import XCTest

final class RegisterViewModelTests: XCTestCase {
    // MARK: - System under test

    // FIXME: Mock dependencies and test them separately
    private let emailValidator = ValidateEmailUseCase()
    private let passwordValidator = ValidatePasswordUseCase()
    private let authenticationServiceDummy = AuthenticationServiceDummy()
    private lazy var sut = RegisterViewModel(emailValidationService: emailValidator,
                                             passwordValidationService: passwordValidator,
                                             authenticationService: authenticationServiceDummy)

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

    func testIsValidEmailShouldAllowValidAddresses() {
        // Given
        let validList = Fixtures.EmailAddresses.validEmails
        let resultStub = true
        let expectedResult = [Bool](repeating: resultStub, count: validList.count)
        var actualResult = [Bool]()

        // When
        validList.forEach {
            let isValid = sut.isValid(email: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(expectedResult, actualResult)
    }

    func testIsValidEmailShouldForbidInvalidAddresses() {
        // Given
        let invalidList = Fixtures.EmailAddresses.invalidEmails
        let resultStub = false
        let expectedResult = [Bool](repeating: resultStub, count: invalidList.count)
        var actualResult = [Bool]()

        // When
        invalidList.forEach {
            let isValid = sut.isValid(email: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(expectedResult, actualResult)
    }

    func testIsValidPasswordShouldAllowValidPasswords() {
        // Given
        let validList = Fixtures.Passwords.validPasswords
        let resultStub = true
        let expectedResult = [Bool](repeating: resultStub, count: validList.count)
        var actualResult = [Bool]()

        // When
        validList.forEach {
            let isValid = sut.isValid(password: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(expectedResult, actualResult)
    }

    func testIsValidPasswordShouldForbidInvalidPasswords() {
        // Given
        let invalidList = Fixtures.Passwords.invalidPasswords
        let resultStub = false
        let expectedResult = [Bool](repeating: resultStub, count: invalidList.count)
        var actualResult = [Bool]()

        // When
        invalidList.forEach {
            let isValid = sut.isValid(password: $0)
            actualResult.append(isValid)
        }

        // Then
        XCTAssertEqual(expectedResult, actualResult)
    }
}
