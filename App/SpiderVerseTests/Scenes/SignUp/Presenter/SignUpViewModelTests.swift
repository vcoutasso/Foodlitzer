@testable import SpiderVerse
import XCTest

final class SignUpViewModelTests: XCTestCase {
    // MARK: - System under test

    // FIXME: Mock dependencies and test them separately
    private let emailValidator = ValidateEmailUseCase()
    private let passwordValidator = ValidatePasswordUseCase()
    private let backendService = BackendUserCreationService()
    private lazy var sut = SignUpViewModel(emailValidationService: emailValidator,
                                           passwordValidationService: passwordValidator,
                                           backendService: backendService)

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
